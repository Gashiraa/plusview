$(document).on("turbolinks:load", function () {
    if ($('#projectId').data('somedata')) {
        $("#project_extra_edit_select").val($('#projectId').data('somedata'));
    }
});
