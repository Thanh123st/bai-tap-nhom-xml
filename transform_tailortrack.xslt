<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://www.ctut.edu.vn/material">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>BÁO CÁO TRUY VẤN XSLT – HỆ THỐNG TIỆM MAY</title>
        <style>
          body { font-family: Arial; margin: 20px; background: #f5f7f9; }
          h1 { text-align: center; color: #1d4ed8; }
          h2 { margin-top: 40px; color: #2563eb; border-bottom: 2px solid #2563eb; padding-bottom: 5px; }
          table { width: 100%; border-collapse: collapse; margin: 20px 0; }
          th, td { border: 1px solid #ccc; padding: 8px; }
          th { background: #e2e8f0; }
          tr:nth-child(even) { background: #f1f5f9; }
        </style>
      </head>
      <body>
        <h1>BÁO CÁO TRUY VẤN DỮ LIỆU XSLT</h1>

        <!-- 1️⃣ Lấy tất cả nhân viên -->
        <h2>1. Danh sách tất cả nhân viên</h2>
        <table>
          <tr><th>Mã NV</th><th>Họ tên</th><th>Chức vụ</th><th>Lương</th></tr>
          <xsl:for-each select="//ns:NhanVien">
            <tr>
              <td><xsl:value-of select="ns:ma_nhan_vien"/></td>
              <td><xsl:value-of select="ns:ho_ten"/></td>
              <td><xsl:value-of select="ns:chuc_vu"/></td>
              <td><xsl:value-of select="ns:luong"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- 2️⃣ Nhân viên có lương > 10 triệu -->
        <h2>2. Nhân viên có lương &gt; 10,000,000</h2>
        <table>
          <tr><th>Mã NV</th><th>Họ tên</th><th>Lương</th></tr>
          <xsl:for-each select="//ns:NhanVien[number(ns:luong) > 10000000]">
            <tr>
              <td><xsl:value-of select="ns:ma_nhan_vien"/></td>
              <td><xsl:value-of select="ns:ho_ten"/></td>
              <td><xsl:value-of select="ns:luong"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- 3️⃣ Khách hàng đăng ký năm 2025 -->
        <h2>3. Khách hàng đăng ký trong năm 2025</h2>
        <table>
          <tr><th>Mã KH</th><th>Họ tên</th><th>Email</th><th>Ngày đăng ký</th></tr>
          <xsl:for-each select="//ns:KhachHang[starts-with(ns:ngay_dang_ky,'2025')]">
            <tr>
              <td><xsl:value-of select="ns:ma_khach_hang"/></td>
              <td><xsl:value-of select="ns:ho_ten"/></td>
              <td><xsl:value-of select="ns:email"/></td>
              <td><xsl:value-of select="ns:ngay_dang_ky"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- 4️⃣ Đơn hàng của khách hàng KH001 -->
        <h2>4. Đơn hàng của khách hàng KH001</h2>
        <table>
          <tr><th>Mã ĐH</th><th>Ngày đặt</th><th>Trạng thái</th><th>Tổng tiền</th></tr>
          <xsl:for-each select="//ns:DonHang[ns:ma_khach_hang='KH001']">
            <tr>
              <td><xsl:value-of select="ns:ma_don_hang"/></td>
              <td><xsl:value-of select="ns:ngay_dat"/></td>
              <td><xsl:value-of select="ns:trang_thai"/></td>
              <td><xsl:value-of select="ns:tong_tien"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- 5️⃣ Nguyên liệu từ NCC003 -->
        <h2>5. Nguyên liệu được cung cấp bởi NCC003</h2>
        <table>
          <tr><th>Mã NL</th><th>Tên nguyên liệu</th><th>Đơn vị</th><th>Giá</th></tr>
          <xsl:for-each select="//ns:NguyenLieu[ns:ma_nha_cung_cap='NCC003']">
            <tr>
              <td><xsl:value-of select="ns:ma_nguyen_lieu"/></td>
              <td><xsl:value-of select="ns:ten_nguyen_lieu"/></td>
              <td><xsl:value-of select="ns:don_vi"/></td>
              <td><xsl:value-of select="ns:gia"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- 6️⃣ Sản phẩm dùng nguyên liệu từ NCC003 -->
        <h2>6. Sản phẩm sử dụng nguyên liệu từ NCC003</h2>
        <table>
          <tr><th>Mã SP</th><th>Tên sản phẩm</th><th>Nguyên liệu</th></tr>
          <xsl:for-each select="
            //ns:SanPham[
              ns:ma_san_pham =
                //ns:SanPhamNguyenLieu[
                  ns:ma_nguyen_lieu =
                    //ns:NguyenLieu[ns:ma_nha_cung_cap='NCC003']/ns:ma_nguyen_lieu
                ]/ns:ma_san_pham
            ]">
            <tr>
              <td><xsl:value-of select="ns:ma_san_pham"/></td>
              <td><xsl:value-of select="ns:ten_san_pham"/></td>
              <td>
                <xsl:for-each select="
                  //ns:NguyenLieu[
                    ns:ma_nguyen_lieu =
                    //ns:SanPhamNguyenLieu[ns:ma_san_pham=current()/ns:ma_san_pham]/ns:ma_nguyen_lieu
                  ]">
                  <xsl:value-of select="ns:ten_nguyen_lieu"/>
                  <xsl:if test="position()!=last()">, </xsl:if>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
