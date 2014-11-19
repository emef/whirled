define(function() {
    return {
        circle_at: function(ctx, x, y, r, color) {
            ctx.beginPath();
            ctx.fillStyle = color;
            ctx.arc(x, y, r, 0, Math.PI * 2);
            ctx.fill();
        }
    };
});
