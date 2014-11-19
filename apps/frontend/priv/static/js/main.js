require.config({
    shim: {
        underscore: {
            exports: '_'
        },
        jquery: {
            exports: '$'
        },
        phoenix: {
            exports: 'Phoenix'
        }
    }
});

require([
    'jquery',
    'underscore',
    'phoenix',
    'draw',
    'colors'],
function($, _, Phoenix, draw, colors) {
    $('#sub').click(CLICK_sub);
    $('#step').click(CLICK_step);

    var _ws;
    function CLICK_sub() {
        try {_ws.close()} catch(e) {}
        _ws = new Phoenix.Socket('ws://localhost:4000/ws');

        _ws.join("games", "id", {}, function(channel) {
            channel.on("state", function(state) {
                update(state);
            });
            window.channel = channel;
        });
    }

    function CLICK_step() {
    }

    function update(state) {
        var out = $('#out');
        out.empty();
        _.each(state.characters, function(char) {
            out.append($('<div>' + JSON.stringify(char) + '</div>'));
        });

        var canvas = $('#canvas')[0];
        var ctx = canvas.getContext('2d');

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.beginPath();

        _.each(state.characters, function(char) {
            var loc = char.location;
            var intention = char.intention;
            var color = colors.for_id(char.char_id);
            ctx.fillStyle = color;
            ctx.moveTo(loc[0], loc[1]);
            draw.circle_at(ctx, loc[0], loc[1], 5, color);

            ctx.globalAlpha = 0.5;
            ctx.beginPath();
            ctx.strokeStyle = color;
            ctx.moveTo(loc[0], loc[1]);
            ctx.lineTo(intention[0], intention[1]);
            ctx.stroke();

            ctx.beginPath();
            draw.circle_at(ctx, intention[0], intention[1], 5, color);

            ctx.globalAlpha = 1.0;
        });
    }

});
