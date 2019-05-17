$(document).on("turbolinks:load", function () {

        //Disabling dropdowns for ware forms
        $('select[id="ware_form_project"]').on('focus trigger mouseover change', function () {
            if ($(this).val()) {
                $('#customer_edit_select').prop("disabled", true);
                $('#status_edit_select option:eq(2)').prop('selected', true);
            } else {
                $('#customer_edit_select').prop("disabled", false);
                $('#status_edit_select option:eq(0)').prop('selected', true);
            }
        });
        $('select[id="ware_form_project"]').trigger('change');

        $('select[id="customer_edit_select"]').on('focus trigger mouseover change', function () {
            if ($(this).val()) {
                $('#ware_form_project').prop("disabled", true);
                $('#status_edit_select option:eq(3)').prop('selected', true);
            } else {
                $('#ware_form_project').prop("disabled", false);
                $('#status_edit_select option:eq(0)').prop('selected', true);
            }
        });
        $('select[id="customer_edit_select"]').trigger('change');


        //WARES PROVIDER PRICES auto-complete
        $('#provider_price,#provider_discount')
            .on('keyup keypress mouseover change', function () {
                let provider_price = document.getElementById('provider_price').value || 0;
                let provider_discount = document.getElementById('provider_discount').value || 0;
                let bought_price = document.getElementById('bought_price');

                let total = parseFloat(provider_price) - ((parseFloat(provider_price) / 100) * parseFloat(provider_discount));

                bought_price.value = total.toFixed(2);
            });
        $('#provider_price').trigger('mouseover');

        //WARES TOTAL auto-complete
        $('#waresForm,#total_cost,#total_gross,#quantity,#bought_price,#tva_rate,#margin')
            .on('keyup keypress mouseover change', function () {
                let total_cost = document.getElementById('total_cost');
                let total_gross = document.getElementById('total_gross');
                let sell_price = document.getElementById('sell_price');
                let quantity = document.getElementById('quantity').value || 0;
                let bought_price = document.getElementById('bought_price').value || 0;
                let margin = document.getElementById('margin').value || 0;
                let tva_rate = document.getElementById('tva_rate').value || 0;

                let sell = parseFloat(bought_price) + ((parseFloat(bought_price) / 100) * parseFloat(margin));
                let gross = (parseInt(quantity) * parseFloat(sell));
                let total = gross * (1 + parseFloat(tva_rate) / 100);

                sell_price.value = sell.toFixed(2);
                total_gross.value = gross.toFixed(2);
                total_cost.value = total.toFixed(2);
            });
        $('#waresForm').trigger('mouseover');

        if ($('#project-id').data('somedata')) {
            $("#ware_form_project").val($('#project-id').data('somedata'));
            $('select[id="ware_form_project"]').trigger('change');
        }
    }
);
