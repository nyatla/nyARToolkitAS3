/* 
 * PROJECT: NyARToolkitAS3
 * --------------------------------------------------------------------------------
 * This work is based on the original ARToolKit developed by
 *   Hirokazu Kato
 *   Mark Billinghurst
 *   HITLab, University of Washington, Seattle
 * http://www.hitl.washington.edu/artoolkit/
 *
 * The NyARToolkitAS3 is AS3 edition ARToolKit class library.
 * Copyright (C)2010 Ryo Iizuka
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * For further information please contact.
 *	http://nyatla.jp/nyatoolkit/
 *	<airmail(at)ebony.plala.or.jp> or <nyatla(at)nyatla.jp>
 * 
 */
package jp.nyatla.nyartoolkit.as3.core.analyzer.raster.threshold 
{
	import jp.nyatla.nyartoolkit.as3.core.raster.*;
	public class NyARRasterThresholdAnalyzer_SlidePTile implements INyARRasterThresholdAnalyzer
	{
		private var _raster_analyzer:NyARRasterAnalyzer_Histgram;
		private var _sptile:NyARHistgramAnalyzer_SlidePTile;
		private var _histgram:NyARHistgram;
		public function setVerticalInterval(i_step:int):void
		{
			this._raster_analyzer.setVerticalInterval(i_step);
			return;
		}
		public function NyARRasterThresholdAnalyzer_SlidePTile(i_persentage:int,i_raster_format:int,i_vertical_interval:int)
		{
			assert (0 <= i_persentage && i_persentage <= 50);
			//初期化
			this._sptile=new NyARHistgramAnalyzer_SlidePTile(i_persentage);
			this._histgram=new NyARHistgram(256);
			this._raster_analyzer=new NyARRasterAnalyzer_Histgram(i_raster_format,i_vertical_interval);
		}
		
		public override function analyzeRaster(i_input:INyARRaster):int
		{
			this._raster_analyzer.analyzeRaster(i_input, this._histgram);
			return this._sptile.getThreshold(this._histgram);
		}
	}
}