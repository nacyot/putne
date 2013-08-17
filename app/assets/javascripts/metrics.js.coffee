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
                "프로젝트의 전반적인 진행 및 상태를 확인할 수 있습니다.")
        popoverForSidebar(
                $('#files-help'),
                "Files help",
                "프로젝트에 포함된 파일들을 나타냅니다.")
        popoverForSidebar(
                $('#classes-help'),
                "Classes help",
                "프로젝트에 포함된 클래스들을 나타냅니다.")
        popoverForSidebar(
                $('#methods-help'),
                "Methdos help",
                "프로젝트에 포함된 메소드들을 나타냅니다.")
        popoverForSidebar(
                $('#churn-help'),
                "Churn help",
                "저장소에서 자주 변경된 파일을 찾아줍니다. 자주 변경되는 파일은 버그가 자주 발생한다고 알려져있습니다.")
        popoverForSidebar(
                $('#complexity-help'),
                "Complexity help",
                "코드의 복잡도를 나타냅니다. 라인수를 비롯해 Flog와 사이클로매틱스 분석법을 채용하고 있습니다.")
        popoverForSidebar(
                $('#duplicity-help'),
                "Duplicity help",
                "중복된 코드를 찾아줍니다. 코드 중복은 추상화를 저해하는 요인으로 프로그램 유지보수에 악영향으로 작용합니다.")
        popoverForSidebar(
                $('#smells-help'),
                "Smells help",
                "악취가 나는 코드를 찾아줍니다. 버그가 아니라고 하더라도 추후 문제가 될 가능성이 많은 코드들을 잡아냅니다.")
        popoverForSidebar(
                $('#report-help'),
                "Report help",
                "프로젝트 분석 보고서 일람입니다. 시간대별로 기록이 저장되어 이곳에서 이전 자료를 다시 확인하고, 현재와 비교해볼 수 있습니다.")
        popoverForSidebar(
                $('#timeline-help'),
                "Timeline help",
                "프로젝트의 시간에 다른 추이를 나타냅니다. 코드 품질의 변화를 한 눈에 확인할 수 있습니다.")
        popoverForSidebar(
                $('#repository-help'),
                "Repository help",
                "프로젝트의 저장소로 이동합니다.")
        popoverForSidebar(
                $('#settings-help'),
                "Project settings"
                "Putne의 보고서와 관련된 설정을 합니다.")


