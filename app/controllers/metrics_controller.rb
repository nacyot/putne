require 'parser/current'

class MetricsController < ApplicationController
  load_and_authorize_resource class: Project

  def files
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def file
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    
    file_name = TargetFile.find(params[:file_id]).path
    @file = (@project.repository.git.last_commit.tree / file_name).data
  end
  
  def classes
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def klass
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])

    file_name = TargetClass.find(params[:class_id]).target_file.path
    @file = (@project.repository.git.last_commit.tree / file_name).data
  end
  
  def methods
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
  end
  
  def churn
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def complexity
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    @methods = @report.target_methods.page(params[:page]).per(25)
  end

  def duplicity
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def smells
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def timeline
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end


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
