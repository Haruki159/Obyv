using ShoesShop.DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ShoesShop.Windows
{
    /// <summary>
    /// Логика взаимодействия для AddEditWindow.xaml
    /// </summary>
    public partial class AddEditWindow : Window
    {
        private Tovar _item; // Переменная для товара
        
        public AddEditWindow(Tovar selected)
        {
            InitializeComponent();
            // 1. Если пришли из "Редактировать" — берем тот товар, если из "Добавить" — создаем новый
            _item = selected ?? new Tovar();
            DataContext = _item;

            // 2. Заполняем выпадающие списки
            ComboPhoto.ItemsSource = Enumerable.Range(1, 10).ToList(); // Числа от 1 до 10
            ComboName.ItemsSource = ObyvEntities.GetContext().NameTovars.ToList();
            ComboManuf.ItemsSource = ObyvEntities.GetContext().Proizvoditels.ToList();
        }

        // Костыль, чтобы картинка обновлялась при выборе номера фото
        private void ComboPhoto_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataContext = null;
            DataContext = _item;
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            // 1. Простейшая проверка (чтобы не писать StringBuilder)
            if (_item.Name == 0 || _item.Chena < 0 || _item.KolVoNaSklade < 0)
            {
                MessageBox.Show("Ошибка! Проверьте данные.");
                return;
            }

            // 2. Если товар новый (ID == 0), добавляем его в таблицу
            if (_item.IDTovar == 0)
                ObyvEntities.GetContext().Tovars.Add(_item);

            // 3. Сохраняем всё в базу
            try
            {
                ObyvEntities.GetContext().SaveChanges();
                DialogResult = true; // Закрываем окно с успехом
            }
            catch(Exception ex) { MessageBox.Show($"Ошибка БД: {ex}"); }
        }
    }
}
