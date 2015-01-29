# coding: utf-8
# Для работы с Таблицей

namespace :table do

  desc 'Update table after 20150129085635_modify_columns'
  task :m20150129085635 => :environment do

    [Account, AccountsDate, Agreement, Client].each do |_model|
      _model.all.each do |el|
        next if el.options.blank?
        YAML.load(el.options).each do |k, v|
          el.send("#{k}=", v)
        end
        el.save
      end
    end

  end
end
