_ = require 'underscore-plus'
jsonpath = require 'jsonpath'
{$, $$, SelectListView} = require 'atom'

module.exports =
class QueryPaletteView extends SelectListView
  @activate: (state) ->
    new QueryPaletteView(state.queryPaletteViewState)

  initialize: ->
    super

    @addClass 'command-palette overlay from-top'
    atom.workspaceView.command 'query-palette:toggle', => @toggle()

  getFilterKey: ->
    'eventDescription'

  toggle: ->
    if @hasParent()
      @cancel()
    else
      @attach()

  attach: ->
    @storeFocusedElement()

    @sourceElement = atom.workspace.getActiveEditor()

    @setItems JSON.parse @sourceElement.buffer.cachedText

    atom.workspaceView.append @
    @focusFilterEditor()

  # Override populateList() to basically make this view work completely
  # differently from the way it's intended
  populateList: ->
    unless @items?
      return

    query = @getFilterQuery()

    # TODO report empty result vs invalid query
    filteredItems = jsonpath.eval @items, query

    if filteredItems?
      @setError null

      @list.empty()
      itemView = @viewForItem filteredItems
      @list.append itemView

  viewForItem: (filteredJSON)->
    $$ ->
      @pre JSON.stringify filteredJSON, null, 2
