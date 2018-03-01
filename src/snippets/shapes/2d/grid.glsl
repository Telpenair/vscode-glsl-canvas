/* Shape 2D grid */
#define PI_TWO			1.570796326794897
mat2 rotate2d(float angle){
    return mat2(cos(angle),-sin(angle), sin(angle), cos(angle));
}
float plot(in vec2 p, in float t, in float a) {
    p *= rotate2d(a);
    return 1.0 - smoothstep(t / 2.0 - rx, t / 2.0 + rx, abs(p.x));
}
float plot(in vec2 p, in float t) { return plot (p, t, 0.0); }
float plot(in vec2 p) { return plot (p, 1.0, 0.0); }
float line(in vec2 a, in vec2 b, float size) {
    vec2 ba = a - b;
    float d = clamp(dot(a, ba) / dot(ba, ba), 0.0, 1.0);
    d = length(a - ba * d);
    return smoothstep(size + rx, size - rx, d);
}
vec2 tile(in vec2 p, vec2 size) { return fract(mod(p + size / 2.0, size)) - (size / 2.0); }
vec2 tile(in vec2 p, float size) { return tile(p, vec2(size)); }
float grid(in float size) {
    float d = 0.0;
    d += plot(tile(st, size), pix(1.0));
    d += plot(tile(st, size), pix(1.0), PI_TWO);
    d *= 0.1;
    vec2 p = tile(st, vec2(size * 5.0, size * 5.0));
    float s = size / 10.0;
    float g = 0.0;
    g += line(p + vec2(-s, 0.0), p + vec2(s, 0.0), pix(1.0));
    g += line(p + vec2(0.0, -s), p + vec2(0.0, s), pix(1.0));
    return d + g;
}