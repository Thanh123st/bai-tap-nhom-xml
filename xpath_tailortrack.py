from pathlib import Path
from lxml import etree

base_dir = Path(__file__).parent
xml_path = base_dir / "TailorTrack_System_useXSD.xml"

tree = etree.parse(str(xml_path))

np = {"ns": "http://www.ctut.edu.vn/material"}

print("=== TRUY VẤN 1: Lấy tất cả mã sản phẩm ===")
for sp in tree.xpath("//ns:SanPham/ns:ma_san_pham/text()", namespaces=np):
    print("-", sp)



print("\n=== TRUY VẤN 2: Lấy đơn hàng của khách hàng KH001 ===")
for dh in tree.xpath("//ns:DonHang[ns:ma_khach_hang='KH001']/ns:ma_don_hang/text()", namespaces=np):
    print("-", dh)

print("\n=== TRUY VẤN 3: Lấy sản phẩm có giá > 50,000 ===")
for sp in tree.xpath("//ns:SanPham[number(ns:gia) > 50000]/ns:ten_san_pham/text()", namespaces=np):
    print("-", sp)

print("\n=== TRUY VẤN 4: Lấy sản phẩm thuộc danh mục 'Quần' ===")
for sp in tree.xpath("//ns:SanPham[ns:ma_danh_muc = //ns:DanhMuc[ns:ten_danh_muc='Quần']/ns:ma_danh_muc]/ns:ten_san_pham/text()", namespaces=np):
    print("-", sp)

print("\n=== TRUY VẤN 5: Lấy nguyên liệu từ nhà cung cấp NCC003 ===")
for nl in tree.xpath("//ns:NguyenLieu[ns:ma_nha_cung_cap='NCC003']/ns:ten_nguyen_lieu/text()", namespaces=np):
    print("-", nl)

print("\n=== TRUY VẤN 6: Lấy sản phẩm sử dụng nguyên liệu 'Vải cotton' ===")
for sp in tree.xpath("""
    //ns:SanPham[
        ns:ma_san_pham = 
            //ns:SanPhamNguyenLieu[
                ns:ma_nguyen_lieu = 
                    //ns:NguyenLieu[ns:ten_nguyen_lieu='Vải cotton']/ns:ma_nguyen_lieu
            ]/ns:ma_san_pham
    ]/ns:ten_san_pham/text()
""", namespaces=np):
    print("-", sp)

