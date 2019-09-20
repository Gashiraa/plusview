$(document).on("turbolinks:load", function () {

    $("#payment_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    }); //PICKING A CUSTOMER IN INVOICE FORM

        $('#payment_form_customer').on('focus load trigger mouseover change', function () {
            let invoice = this.options[this.selectedIndex].value;
            $("#select_invoices_payment > option").each(function () {
                if (this.getAttribute("invoice") === invoice) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
        });
        $('#payment_form_customer').trigger('change');
    }
);