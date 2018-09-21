# frozen_string_literal: true

json.array! @wines, partial: 'wines/wine', as: :wine
