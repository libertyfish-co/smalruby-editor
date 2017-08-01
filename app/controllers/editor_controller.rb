# -*- coding: utf-8 -*-
require "ostruct"

class EditorController < ApplicationController
  def index
    @passcode = Passcode.new
  end

  def demo
    @filename = (File.basename(params[:filename]) || 'car_chase') + '.rb.xml'
  end

  def toolbox
    render :toolbox, layout: false
  end
end
