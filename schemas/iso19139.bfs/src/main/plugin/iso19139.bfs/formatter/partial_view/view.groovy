def isoHandlers = new iso19139bfs.Handlers(handlers, f, env)

isoHandlers.addDefaultHandlers()
handlers.start {}
handlers.end {}
