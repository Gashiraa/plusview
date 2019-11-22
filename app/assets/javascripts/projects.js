$(document).on("turbolinks:load", function () {

    $("#project_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    }); //PICKING A CUSTOMER IN PROJECT FORM

    if ($('#project-id').data('somedata')) {
        $("#invoice_form_projects").val([$('#project-id').data('somedata')]);
    }

    $('.ui.checkbox')
        .checkbox()
    ;

    $("#project_no_vat").change(function() {
        if (this.checked) {
            $("#project_comment").val("Autoliquidation Art 21 § 2 du code TVA belge");
        }
     });
    $('.description-cell')
        .popup()
    ;
});
