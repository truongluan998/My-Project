package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.TopicsDto;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelReportTopic extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        response.setHeader("Content-Disposition", "attachment;filename=\"topic.xls\"");
        List<TopicsDto> topicList = (List<TopicsDto>) model.get("topicList");
        Sheet sheet = workbook.createSheet("Topic data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Image");
        header.createCell(2).setCellValue("Name");
        header.createCell(3).setCellValue("Game");
        header.createCell(4).setCellValue("Active");

        int rowNum = 1;
        for (TopicsDto tl : topicList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(tl.getId());
            row.createCell(1).setCellValue(tl.getImage());
            row.createCell(2).setCellValue(tl.getName());
            row.createCell(3).setCellValue(tl.getGameId().getName());
            row.createCell(4).setCellValue(tl.getIsActive().toString());
        }

    }
}
