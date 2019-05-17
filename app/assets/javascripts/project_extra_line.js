$(document).on("turbolinks:load", function () {
        $('#extra_edit_select').on('focus load trigger mouseover change', function () {
            let extra = this.options[this.selectedIndex].value;
            $("#extra_unit_price > option").each(function () {
                if (this.getAttribute("extra") === extra) {
                    this.style.display = "block";
                    $('#extra_unit_price').val(extra);
                } else {
                    this.style.display = "none";
                }
            });
            $("#extra_unit > option").each(function () {
                if (this.getAttribute("extra") === extra) {
                    this.style.display = "block";
                    $('#extra_unit').val(extra);
                } else {
                    this.style.display = "none";
                }
            });
            $("#extra_tva_rate > option").each(function () {
                if (this.getAttribute("extra") === extra) {
                    this.style.display = "block";
                    $('#extra_tva_rate').val(extra);
                } else {
                    this.style.display = "none";
                }
            });
        });
        $('#extra_edit_select').trigger('change');

        $('#category_select_extra_line').on('load trigger change', function () {
            let category = this.options[this.selectedIndex].text;
            $("#extra_edit_select > option").each(function () {
                if (this.getAttribute("category") === category) {
                    this.style.display = "block";
                    $('#extra_edit_select').val(this.value);
                } else {
                    this.style.display = "none";
                }
            });
            $('#extra_edit_select').trigger('change');
        });
        $('#category_select_extra_line').trigger('change');


        $('#extra_edit_select,#edit_project_extra_line,#extra_total_gross,#extra_total,#extra_quantity,#extra_tva_rate')
            .on('keyup keypress mouseover change', function () {
                let quantity = document.getElementById('extra_quantity').value || 0;
                let tva_rate = document.getElementById('extra_tva_rate').options[document.getElementById('extra_tva_rate').selectedIndex].text || 0;
                let extra_unit_price = document.getElementById('extra_unit_price').options[document.getElementById('extra_unit_price').selectedIndex].text || 0;
                let extra_total_gross = document.getElementById('extra_total_gross');
                let extra_total = document.getElementById('extra_total');

                let gross = (parseInt(quantity) * parseFloat(extra_unit_price));
                let total = gross * (1 + (parseFloat(tva_rate) / 100));

                extra_total_gross.value = gross.toFixed(2);
                extra_total.value = total.toFixed(2);
            });
        $('#extra_total_gross').trigger('mouseover');

        if ($('#project-id').data('somedata')) {
            $("#project_extra_edit_select").val($('#project-id').data('somedata'));
        }
    }
);
