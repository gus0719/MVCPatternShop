package shop;

import java.awt.Frame;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Color;
import java.awt.event.WindowEvent;
import java.awt.event.ActionEvent;
import java.awt.event.WindowAdapter;
import java.awt.Button;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Panel;
import java.awt.Label;
import java.awt.Font;

public class ShopGUI extends Frame {

	// 종료--------------------------------------------------
	public ShopGUI() {
		WindowAdapter window = new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				dispose();
			}
		};
		addWindowListener(window);
	}
	// -------------------------------------------------

	public void guiRun(String str, String sub) {
		// 객체 생성
		ShopGUI obj01 = new ShopGUI();

		// 버튼 생성
		Button btn = new Button("종료");

		// Label 배열 생성
		Label[][] lab = { { new Label("Dream 공지사항") },

				{ new Label("팀원  :"),
				  new Label("이름1 ,"),
				  new Label("이름2 ,"),
				  new Label("이름3 ,"),
				  new Label("이름4") },

				{ new Label(str) },

				{ new Label(sub) },

				{ new Label() } };

		Panel panel[] = new Panel[lab.length];

		// 배열 Loop 적용
		for (int outer = 0; outer < lab.length; outer++) {
			panel[outer] = new Panel();
			if (lab[outer].length <= 1) {
				panel[outer].add(lab[outer][0]);
			} else {
				for (int inner = 0; inner < lab[1].length; inner++) {
					panel[outer].add(lab[outer][inner]);
				}
			}
		}

		panel[lab.length - 1].add(btn);

		panel[0].setFont(new Font("궁서체", Font.ITALIC | Font.BOLD, 30));
		obj01.add(BorderLayout.NORTH, panel[0]);

		panel[1].setFont(new Font("돋음", Font.BOLD, 15));
		for (int i = 0; i < lab[0].length; i++) {
			obj01.add(BorderLayout.CENTER, panel[1]);
		}

		panel[2].setFont(new Font("돋음", Font.BOLD, 20));
		obj01.add(BorderLayout.CENTER, panel[2]);
		obj01.add(BorderLayout.CENTER, panel[3]);

		panel[lab.length - 1].setBackground(Color.white);
		panel[lab.length - 1].setFont(new Font("돋음", Font.BOLD, 15));

		obj01.add(BorderLayout.SOUTH, panel[lab.length - 1]);

		btn.setPreferredSize(new Dimension(100, 50));
		btn.addActionListener(event -> {
			System.out.println("GUI Exit");
			obj01.dispose();
		});

		obj01.setLayout(new GridLayout(5, 1, 50, 10));

		obj01.setTitle("Dream 공지");
		obj01.setSize(400, 500);
		obj01.setLocation(100, 100);
		obj01.setVisible(true);
	}
}