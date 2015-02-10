# coding: utf-8
# Для работы с Таблицей

namespace :table do

  desc 'Update table after 20150129085635_modify_columns'
  task :m20150129085635 => :environment do

    [Account, RecordsDate, Agreement, Client].each do |_model|
      _model.all.each do |el|
        next if el.options.blank?
        YAML.load(el.options).each do |k, v|
          el.send("#{k}=", v)
        end
        el.save
      end
    end

  end

  desc 'Update table after 20150209103411_add_account_type_to_accounts_dates'
  task :m20150209103411 => :environment do

    RecordsDate.update_all(recordable_type: 'Account')

  end

  desc 'Update indicatorRules when they are ready'
  task :update_ready => :environment do
    %w{оссзкрДОВи1221_ИБСО_т}.each do |sh_name|
      i = Indicator.find_by_sh_name(sh_name)
      i.children_rules.update_all(:ready => true)
    end
  end
end
