import iso19139bfsSummaryFactory

def isoHandlers = new iso19139bfs.Handlers(handlers, f, env)

SummaryFactory.summaryHandler({it.parent() is it.parent()}, isoHandlers)

isoHandlers.addDefaultHandlers()
