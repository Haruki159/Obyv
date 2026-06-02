using ShoesShop.DataBase;
using ShoesShop.Windows;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace ShoesShop.Pages
{
    public partial class ProductsPage : Page
    {
        public ProductsPage()
        {
            InitializeComponent();
            var manufs = ObyvEntities.GetContext().Postavchiks.ToList();
            manufs.Insert(0, new Postavchik { PostavchikName = "Все" });
            CmbManufacturer.ItemsSource = manufs;
            CmbManufacturer.SelectedIndex = 0;
            LoadData();
        }

        private void LoadData()
        {
            var list = ObyvEntities.GetContext().Tovars
                .ToList();

            if (TxtSearch.Text != "")
                list = list.Where(p => p.NameTovar.NaimenovanieTovara.ToLower().Contains(TxtSearch.Text.ToLower())).ToList();

            if (CmbManufacturer.SelectedIndex > 0)
                list = list.Where(p => p.Postavchik1.IDPostavchik == (CmbManufacturer.SelectedItem as Postavchik).IDPostavchik).ToList();

            if (CmbSort.SelectedIndex == 1) list = list.OrderBy(p => p.KolVoNaSklade).ToList();
            if (CmbSort.SelectedIndex == 2) list = list.OrderByDescending(p => p.KolVoNaSklade).ToList();

            LBoxProducts.ItemsSource = list;
        }

        private void FilterChanged(object sender, TextChangedEventArgs e) => LoadData();
        private void FilterChanged(object sender, SelectionChangedEventArgs e) => LoadData();

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            new AddEditWindow(null).ShowDialog();
            LoadData();
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            var item = LBoxProducts.SelectedItem as Tovar;
            if (item != null)
            {
                new AddEditWindow(item).ShowDialog();
                LoadData();
            }
        }

        private void Del_Click(object sender, RoutedEventArgs e)
        {
            var item = LBoxProducts.SelectedItem as Tovar;

            // Если товар выбран И мы нажали "Да" в окошке:
            if (item != null && MessageBox.Show("Удалить?", "!", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
                var db = ObyvEntities.GetContext();
                db.Tovars.Remove(item);
                db.SaveChanges();
                LoadData();
            }
        }
    }
}