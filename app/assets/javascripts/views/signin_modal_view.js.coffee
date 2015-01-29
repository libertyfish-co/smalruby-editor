# ログインダイアログを表現するビュー
Smalruby.SigninModalView = Backbone.View.extend
  events:
    'click #signin-modal-ok-button': 'onOk' # FIXME: 本当は#signin-modal .ok-buttonを指定したいができなかった

  initialize: ->
    Smalruby.ignoreEnterKey(@$el)
    @$el.on 'shown', =>
      @$el.find('#signin-modal-username')
        .focus()

  render: ->
    @$el.find('#signin-modal-username')
      .val($('#username-label').text())
    @$el.modal
      backdrop: 'static'
    @$el.modal('show')

  onOk: (e) ->
    username = @$el.find('input[name=username]').val()
    if $.trim(username).length > 0
      $.post('/sessions/', { username: username })
        .then(
          (data) ->
            Smalruby.username = data
            $('#signin-button').hide()
            $('#signout-button').show()
            $('#username-label').text(data)
            $('#username-button').show()
            successMessage('ログインしました')
            new $.Deferred().resolve().promise()
          ->
            errorMessage('ログインに失敗しました')
            new $.Deferred().resolve().promise()
        )
        .done =>
          if Smalruby.username != null || !Smalruby.isEnabled('must_signin')
            @$el.modal('hide')
