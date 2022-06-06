using HTTP
using Sockets
println("Server staring")
const ROUTER = HTTP.Router()
HTTP.@register(ROUTER, "GET", "/header", req-> begin
    r = HTTP.Messages.headers(req)
    header = " "
    for pair in r
        header = header*"$(pair[1]): $(pair[2])\n"
    end
    HTTP.Response(200, "\n$(header)")
end
)
HTTP.@register(ROUTER, "GET", "/", req -> HTTP.Response(read("roadmap.html")))
HTTP.@register(ROUTER,"GET", "/Filmik", req -> HTTP.Response(read("Filmik.html")))
HTTP.@register(ROUTER,"GET", "/GIF", req -> HTTP.Response(read("SMAKOWICIE.gif")))
HTTP.@register(ROUTER,"GET", "/Tekst", req -> HTTP.Response(read("Tekst.html")))
HTTP.@register(ROUTER, "GET", "/*", req->HTTP.Response(404, "Brak Strony"))
HTTP.serve(ROUTER,Sockets.localhost,2137)