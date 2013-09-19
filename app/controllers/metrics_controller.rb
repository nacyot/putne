require 'parser/current'

class MetricsController < ApplicationController
  load_and_authorize_resource class: Project
  layout "layouts/sidebar"

  def files
    @title = "Files"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    @files = @report.target_files.page(params[:page]).per(25)
  end

  def file
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    
    file_name = TargetFile.find(params[:file_id]).path
    @file = (@project.repository.git.last_commit.tree / file_name).data

    @title = "File viewer - #{file_name}"
  end
  
  def classes
    @title = "Classes"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    @classes = @report.target_classes.page(params[:page]).per(25)
  end

  def klass
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])

    file_name = TargetClass.find(params[:class_id]).target_file.path
    @file = (@project.repository.git.last_commit.tree / file_name).data
    @title = "Class viewer - #{file_name}"
  end
  
  def methods
    @title = "Methods"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    @methods = @report.target_methods.page(params[:page]).per(25)
  end

  def method
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])

    method = TargetMethod.find(params[:method_id])

    if method.name =~ /#/
      method_name = method.name.split('#')[1]
    else
      method_name = method.name.split('::')[-1]
    end
    
    file_name = TargetMethod.find(params[:method_id]).target_class.target_file.path
    file = (@project.repository.git.last_commit.tree / file_name).data

    @method = ""
    @method_name = method_name
    find_source_code file, method_name

    @title = "Method vierew - #{@method_name}"
  end
  
  def churn
    @title = "Churns"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def complexity
    @title = "Complexities"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    @methods = @report.target_methods.page(params[:page]).per(25)
  end

  def duplicity
    @title = "Duplications"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def smells
    @title = "Smells"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def timeline
    @titmle = "Timeline"
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  private
  def find_source_code(file, method_name)
    ast_root = Parser::CurrentRuby.parse(file)
    recursive_search_ast(ast_root, method_name)
  end

  def recursive_search_ast(ast, name)
    ast.children.each do |child|
      if child.class.to_s == "Parser::AST::Node"
        if (child.type.to_s == "def" or child.type.to_s == "defs") and (child.children[0].to_s == name or child.children[1].to_s == name)
          @method = child.source_map.expression.to_source
          return 
        else
          recursive_search_ast(child, name)
        end
      end
    end
  end
end
