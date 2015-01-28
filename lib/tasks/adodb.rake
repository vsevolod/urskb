# coding: utf-8
# Для работы с ADODB (Access DB)

require './lib/adodb_connection'
require './lib/update_tables'
include UpdateTables

def ptable(table_name, &block)
  print "#{table_name} started: "
  block.call
  puts "!"
end

namespace :adodb do

  desc 'Update table in nsequence'
  task :update do
    @@dic_hash = {}
    @@object_hash = {}
    Rake::Task['adodb:update:dictionaries'].invoke
    Rake::Task['adodb:update:main'].invoke
    Rake::Task['adodb:update:agreements'].invoke
    Rake::Task['adodb:update:accounts'].invoke
    Rake::Task['adodb:update:other'].invoke
  end

  namespace :update do

    desc 'Update dictionary table'
    task dictionaries: :environment do
      ptable 'Сегменты, группы сегментов' do
        update_table('./public/files/db.accdb', 'SegmentGroup')
        update_table('./public/files/db.accdb', 'Segment')
      end
      ptable 'Разновидность показателя' do
        update_table('./public/files/Settings/Settings.accdb', 'PokazatVar')
      end
      ptable 'Таблицы' do
        update_table('./public/files/Settings/Settings.accdb', 'IstTable')
      end
    end

    desc 'Update main tables'
    task :main do
      ptable 'Показатель' do
        #update_table('./public/files/Settings/Settings.accdb', 'Pokazat')
      end
      ptable 'Правила показателей' do
        update_table('./public/files/Settings/Settings.accdb', 'PokRules')
      end
      ptable 'Подразделения' do
        #update_table('./public/files/Settings/Settings.accdb', 'Podrazd')
        #Option.where(objectable_type: 'Division', key: 'report_names').delete_all
        #update_table('./public/files/Settings/Settings.accdb', 'PodrazdNames')
      end
    end

    desc 'Update agreement tables'
    task agreements: :environment do
      ptable 'Кредитные договоры' do
        update_table('./public/files/tables/66_krAccDog.accdb', '66_krAccDog')
      end
      ptable 'Депозитные договоры' do
        update_table('./public/files/tables/55_spisDep_IB.accdb', '55_spisDep_IB')
      end
      ptable 'Договоры на РКО' do
        update_table('./public/files/tables/34_407_474_426_Ib.accdb', '34_407_474_426_Ib')
      end
    end

    desc 'Update accounts tables'
    task accounts: :environment do
      ptable '53 таблица' do
        update_table('./public/files/tables/q1_2015_53_54.accdb', '53_krOstSr_IB')
      end
    end

    desc 'Update other tables'
    task other: :environment do
      # empty
    end

  end

end
