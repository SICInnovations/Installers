var IFrameValueOld = {}
$(document).ready(function () {
    MonitorIframe();
});


//Sets/Reset Iframe
function MonitorIframe() {
    var z = $("iframe[id*='WebHtmlEditor']");
    $.each(z, function (index, value) {
        IFrameValueOld[$(value).attr('id')] = $(value).contents().find('body').html()
    });
}


//Checks For Form Changes
function FormChanges(form) {
    var Iframe;
    // get form
    if (typeof form == "string") {
        Iframe = $('#' + form).find("iframe[id*='WebHtmlEditor']");
        form = document.getElementById(form);
    }
    if (!form || !form.nodeName || form.nodeName.toLowerCase() != "form") return null;

    // find changed elements
    var changed = [], n, c, def, o, ol, opt;
    c = false;
    $.each(Iframe, function (index, value) {
        c = (IFrameValueOld[value.id] != $(value).contents().find('body').html());
        if (c) changed.push(value);
    });
    for (var e = 0, el = form.elements.length; e < el; e++) {
        n = form.elements[e];

        switch (n.nodeName.toLowerCase()) {

            // select boxes

            case "select":
                def = 0;
                for (o = 0, ol = n.options.length; o < ol; o++) {
                    opt = n.options[o];
                    c = c || (opt.selected != opt.defaultSelected && !(opt.selected == " "));
                    if (opt.defaultSelected) def = o;
                }
                if (c && !n.multiple) c = (def != n.selectedIndex);
                break;

                // input / textarea
            case "textarea":
            case "img":
            case "div":
            case "input":

                switch (n.type.toLowerCase()) {
                    case "checkbox":

                        c = (n.checked != n.defaultChecked);


                        break;
                    case "radio":
                        // checkbox / radio
                        c = (n.checked != n.defaultChecked);
                        break;
                    default:
                        {

                            c = (n.value != n.defaultValue);
                        }
                        break;
                }
                break;
        }


        if (c) changed.push(n);
    }

    return changed;

}