$(document).on("turbolinks:load", function () {

    $("#quotation_form_customer").select2({theme: "bootstrap", width: '100%', selectOnClose: true}); //PICKING A CUSTOMER IN QUOTATION FORM

    $('#quotation_form_customer').on('focus load trigger mouseover change', function () {
            let customer = this.options[this.selectedIndex].value;
            $("#edit_quotation_projects > option").each(function () {
                if (this.getAttribute("customer") === customer || this.innerText === "") {
                    this.style.display = "block";
                    if (this.getAttribute("customer") === customer) {
                        document.getElementById('edit_quotation_projects').value = this.value;
                    }
                    else {
                        document.getElementById('edit_quotation_projects').value = "";
                    }
                } else {
                    this.style.display = "none";
                }
            });
        });
        $('#quotation_form_customer').trigger('change');
    }
);