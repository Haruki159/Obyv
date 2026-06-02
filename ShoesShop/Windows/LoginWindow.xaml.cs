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
    /// Логика взаимодействия для LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        // Кнопка "Войти как гость"
        private void BtnGuest_Click(object sender, RoutedEventArgs e)
        {
            MainWindow main = new MainWindow(); // Передаем null для гостя
            main.Show();
            this.Close();
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            string login = TxtLogin.Text;
            string password = PwdPassword.Password;

            // 2. Ищем такого пользователя в базе
            var user = ObyvEntities.GetContext().Users.FirstOrDefault(u => u.Login == login && u.Parol == password);

            // 3. Проверяем: нашли или нет?
            if (user != null)
            {
                new MainWindow().Show();
                Close();
            }
            else
            {
                MessageBox.Show("Неверный логин или пароль!"); // Ошибка
            }
        }
    }
}
