$(document).on("turbolinks:load", function () {

        $('#customer_select_invoice').on('focus load trigger mouseover change', function () {
            let customer = this.options[this.selectedIndex].value;
            $("#select_wares_invoice > option").each(function () {
                if (this.getAttribute("customer") === customer) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
            $("#select_projects_invoice > option").each(function () {
                if (this.getAttribute("customer") === customer) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
        });
        $('#customer_select_invoice').trigger('change');
    }
);
