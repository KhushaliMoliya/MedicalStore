using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;
using System.IO;

namespace Student
{
    public partial class Form1 : Form
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        String s = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\khush\source\repos\Student\Student\student.mdf;Integrated Security=True";
        String i, d;
        public Form1()
        {
            InitializeComponent();
        }
        void connection()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void uploadimage()
        {
            openFileDialog1.ShowDialog();
            try
            {
                i = openFileDialog1.FileName.ToString();
                pctimg.Load(i);
            }
            catch (Exception res)
            {
            }
        }

        private void btnupload_Click(object sender, EventArgs e)
        {
            uploadimage();
        }

        private void btnsave_Click(object sender, EventArgs e)
        {
            connection();
            //uploadimage();
            string dt = DateTime.Now.ToBinary().ToString();
            d = Application.StartupPath + "\\Images\\" + dt + "_" + openFileDialog1.SafeFileName.ToString();
            System.IO.File.Copy(i, d);

            cmd = new SqlCommand("insert into Stud_tbl(Stud_Name,Stud_Gender,Stud_Email,Stud_Address,Stud_Mobile,Stud_Image)values('" + txtnm.Text + "','"+txtg.Text+"','" + txtemail.Text + "','" + txtadd.Text + "','" + txtphone.Text + "','" + d + "')", con);
            cmd.ExecuteNonQuery();
        }
        private void form1_Load(object sender, EventArgs e)
        {
            connection();
            
        }
    }
}
