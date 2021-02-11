document.addEventListener("turbolinks:load", function() {

    $input = $('*[data-behavior="autocomplete"]')

    var options = {
        url: function(phrase) {
            return "/categories/search.json?q=" + phrase;
        },
        getValue: "name",
    };

    $input.easyAutocomplete(options);

});
