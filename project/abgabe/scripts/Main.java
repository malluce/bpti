package sprites;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Main {

	public static void main(String[] args) throws IOException {
		for (int i = 0; i < args.length; i++) {
			System.out.println(args[i].substring(args[i].lastIndexOf('/'), args[i].length() - 1));
			File file = new File(args[i]);
			BufferedImage img = ImageIO.read(file);
			int[][] sprite;

			int pixel, alpha, red, green, blue, blueNorm, greenNorm, redNorm;
			String redStr, greenStr, blueStr;

			int size = img.getHeight();
			for (int x = 0; x < size; x++) {
				System.out.print("x\"");
				for (int y = 0; y < size; y++) {
					pixel = img.getRGB(y, x);
					alpha = (pixel >> 24) & 0xff;
					red = (pixel >> 16) & 0xff;
					green = (pixel >> 8) & 0xff;
					blue = pixel & 0xff;

					// norm so that max value is 15 (4 bits per channel)
					redNorm = (red == 0) ? 0 : (red / 16) - 1;
					greenNorm = (green == 0) ? 0 : (green / 16) - 1;
					blueNorm = (blue == 0) ? 0 : (blue / 16) - 1;

					redStr = Integer.toHexString(redNorm).toUpperCase();
					blueStr = Integer.toHexString(blueNorm).toUpperCase();
					greenStr = Integer.toHexString(greenNorm).toUpperCase();
					//System.out.println("x, y: " + x + ", " + y);
					//System.out.println("alpha: " + alpha + ", red: " + red + ",green: " + green + ", blue: " + blue);
					//System.out.println("red: " + redStr + ", green: " + greenStr + ", blue: " + blueStr);
					System.out.print(redStr + greenStr + blueStr);
				}
				System.out.print("\",\n");
			}
		}
	}

}
