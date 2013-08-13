# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

popoverForSidebar = (target, title, content) ->
        options = {
                trigger: "hover",
                placement: "left",
                title: title,
                content: content
        }
        target.popover(options)

$ ->
        popoverForSidebar(
                $('#synopsis-help'),
                "Sysnopsis help",
                "This is project overview")
        popoverForSidebar(
                $('#files-help'),
                "Files help",
                "This is project overview")
        popoverForSidebar(
                $('#classes-help'),
                "Classes help",
                "This is project overview")
        popoverForSidebar(
                $('#methods-help'),
                "Methdos help",
                "This is project overview")
        popoverForSidebar(
                $('#churn-help'),
                "Churn help",
                "This is project overview")
        popoverForSidebar(
                $('#complexity-help'),
                "Complexity help",
                "This is project overview")
        popoverForSidebar(
                $('#duplicity-help'),
                "Duplicity help",
                "This is project overview")
        popoverForSidebar(
                $('#smell-help'),
                "Smells help",
                "This is project overview")
        popoverForSidebar(
                $('#report-help'),
                "Report help",
                "This is project overview")
        popoverForSidebar(
                $('#timeline-help'),
                "Timeline help",
                "This is project overview")
        popoverForSidebar(
                $('#repository-help'),
                "Repository help",
                "This is project overview")
        popoverForSidebar(
                $('#settings-help'),
                "Settings help",
                "This is project overview")


