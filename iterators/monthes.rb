month = { 'Январь'    => 30,
          'Февраль'  => 28,
          'Март'     => 30,
          'Апрель'   => 30,
          'Май'      => 31,
          'Июнь'     => 30,
          'Июль'     => 31,
          'Август'   => 31,
          'Сентябрь' => 30,
          'Октябрь'  => 31,
          'Ноябрь'   => 30,
          'Декабрь'  => 30 }

month.each_pair{|month,days| puts month if days == 30 }