# frozen_string_literal: true

Figaro.require_keys('RAILS_ENV',
                    'RAKE_ENV',
                    'DB_HOST',
                    'DB_NAME',
                    'DB_USER',
                    'DB_PASSWORD',
                    'POOL')
