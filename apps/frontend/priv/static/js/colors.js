define(function() {
    function hsv_to_rgb(h, s, v) {
        var h_i = Math.floor(h*6);
        var f = h*6 - h_i;
        var p = v * (1 - s);
        var q = v * (1 - f*s);
        var t = v * (1 - (1 - f) * s);
        var r, g, b;

        if (h_i == 0) {
            r = v, g = t, b = p;
        } else if (h_i == 1) {
            r = q, g = v, b = p;
        } else if (h_i == 2) {
            r = p, g = v, b = t;
        } else if (h_i == 3) {
            r = p, g = q, b = v;
        } else if (h_i == 4) {
            r = t, g = p, b = v;
        } else {
            r = v, g = p, b = q;
        }

        return [Math.floor(r * 256),
                Math.floor(g * 256),
                Math.floor(b * 256)];
    }

    var exports = {};


    var h = 0, golden_ratio_conjugate = 0.618033988749895;
    exports.random = function() {
        h += golden_ratio_conjugate;
        h = h % 1;
        var rgb = hsv_to_rgb(h, 0.25, 0.8);
        return 'rgb(' + rgb.join() + ')';
    };

    var _colors = {};
    exports.for_id = function(id) {
        if (!_colors[id]) {
            _colors[id] = exports.random();
        }
        return _colors[id];
    };

    return exports;
});
