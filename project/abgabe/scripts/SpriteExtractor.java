import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

/**
 * We used this class to extract VHDL arrays from 32x32 sprites.
 * 
 */
public class SpriteExtractor {

	/**
	 * Writes the VHDL arrays to the console (we copy pasted it from there to the VHDL ROM-files).
	 * 
	 * @param args
	 *            command line arguments should contain the paths of the sprites
	 * @throws IOException
	 */
	public static void main(String[] args) throws IOException {
		for (int i = 0; i < args.length; i++) {
			// write to console which sprite is converted next
			System.out.println(args[i].substring(args[i].lastIndexOf('/'), args[i].length() - 1));

			// read sprite
			File file = new File(args[i]);
			BufferedImage img = ImageIO.read(file);

			int pixel, red, green, blue, blueNorm, greenNorm, redNorm;
			String redStr, greenStr, blueStr;

			int size = img.getHeight();

			// iterate over the image
			for (int x = 0; x < size; x++) {
				System.out.print("x\""); // output is in hex, so each row of the array starts with x"
				for (int y = 0; y < size; y++) {
					// get rgb values of the sprite
					pixel = img.getRGB(y, x);
					red = (pixel >> 16) & 0xff;
					green = (pixel >> 8) & 0xff;
					blue = pixel & 0xff;

					/*
					 * norm so that max value of each rgb channel is 15 (4 bits per channel) like on the FPGA -> max of
					 * the sprites here is 255 -> divide by 16
					 */
					redNorm = (red == 0) ? 0 : (red / 16) - 1;
					greenNorm = (green == 0) ? 0 : (green / 16) - 1;
					blueNorm = (blue == 0) ? 0 : (blue / 16) - 1;

					// convert each number to hex
					redStr = Integer.toHexString(redNorm).toUpperCase();
					blueStr = Integer.toHexString(blueNorm).toUpperCase();
					greenStr = Integer.toHexString(greenNorm).toUpperCase();

					System.out.print(redStr + greenStr + blueStr); // fills the row of the VHDL array
				}
				/*
				 * when a row is finished the closing " of the std_logic_vector needs to be added
				 */
				System.out.print("\",\n");
			}
		}
	}

}
	