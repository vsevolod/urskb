module States

  def self.included(base)
    base.class_eval do
      include AASM
    end
    base.aasm column: 'state' do
      state :open                  # Открыт
      state :reserved              # Зарезервирован дистанционно
      state :marked_for_open       # Помечен к открытию
      state :worked, initial: true # Работает
      state :closed                # Закрыт
    end
  end

end
