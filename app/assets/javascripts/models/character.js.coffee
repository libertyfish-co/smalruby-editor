Smalruby.Character = Backbone.Model.extend({
  defaults:
    name: null
    costumes: [],
    costumeIndex: 0
    x: 0
    y: 0
    angle: 0
    visible: true
    using: false

  initialize: ->
    @objects = []
    if @get('costumes').length == 0
      @set({ costumes: [Smalruby.Character.PRESET_COSTUMES[0]] })

  validate: (attrs, options) ->
    errors = []

    name = attrs.name
    if _.isUndefined(name) || _.isNull(name) ||
       (_.isString(name) && name.length == 0)
      errors.push
        attr: 'name'
        message: 'Name is required'

    if _.isString(name) &&
       name.match(/^[0-9A-Z]|[!\"\#$%&\'()\-=^~\\|@`\[{;+:*\]},<.>/?]/)
      errors.push
        attr: 'name'
        message: 'Name is invalid'

    if errors.length > 0
      return errors

    return

  link: (object) ->
    @objects.push(object)
    @objects = _.uniq(@objects)
    if @objects.length > 0
      @set('using', true)

  unlink: (object) ->
    @objects = _.without(@objects, object)
    if @objects.length == 0
      @set('using', false)

  namePrefix: ->
    Smalruby.Character.costumeToNamePrefix(@get('name'))

  costume: ->
    @get('costumes')[@get('costumeIndex')]

  costumeUrl: (index = @get('costumeIndex')) ->
    basename = @get('costumes')[index]
    if _.indexOf(Smalruby.Character.PRESET_COSTUMES, basename) == -1
      basename
    else
      "/smalruby/assets/#{basename}"

  nextCostume: ->
    i = @get('costumeIndex') + 1
    i = 0 if i >= @get('costumes').length
    @set({ 'costumeIndex': i })
    i
}, {
  PRESET_COSTUMES: [
    'car1.png'
    'car2.png'
    'car3.png'
    'car4.png'
    'ball1.png'
    'ball2.png'
    'ball3.png'
    'ball4.png'
    'ball5.png'
    'ball6.png'
    'cat1.png'
    'cat2.png'
    'cat3.png'
    'frog1.png'
  ]

  costumeToNamePrefix: (costume) ->
    costume.substring(costume.lastIndexOf('/') + 1).replace(/\.[^.]*$/, '').replace(/[\d]*$/, '')
})
