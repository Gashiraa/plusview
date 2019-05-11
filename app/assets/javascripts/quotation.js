$(document).on("turbolinks:load", function () {

        $('#customer_edit_select').on('focus load trigger mouseover change', function () {
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
        $('#customer_edit_select').trigger('change');
    }
);