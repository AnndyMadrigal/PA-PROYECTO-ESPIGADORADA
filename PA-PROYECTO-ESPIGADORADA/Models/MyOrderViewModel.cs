using System;
using System.Collections.Generic;

namespace PA_PROYECTO_ESPIGADORADA.Models
{
    public class MyOrderViewModel
    {
        public int SalesInvoiceId { get; set; }
        public string SalesNumber { get; set; }
        public DateTime SalesDate { get; set; }
        public string Status { get; set; }
        public string PaymentMethod { get; set; }
        public string PaymentReference { get; set; }
        public decimal Subtotal { get; set; }
        public decimal DiscountTotal { get; set; }
        public decimal TaxTotal { get; set; }
        public decimal Total { get; set; }
        public string Notes { get; set; }
        public List<MyOrderLineViewModel> Lines { get; set; } = new List<MyOrderLineViewModel>();
    }

    public class MyOrderLineViewModel
    {
        public string ProductName { get; set; }
        public decimal Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TaxAmount { get; set; }
        public decimal LineTotal { get; set; }
    }
}
