package com.atensys.imake.draw.component {
	import com.atensys.imake.draw.DrawDesktop;
	import com.atensys.imake.draw.ttip.ComponentToolTip;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;

	public class ComponentResizeContainer extends UIComponent {
		private var buttonLU:Button;
		private var buttonLM:Button;
		private var buttonLD:Button;
		private var buttonCU:Button;
		private var buttonCD:Button;
		private var buttonRU:Button;
		private var buttonRM:Button;
		private var buttonRD:Button;
		private var buttonC:Button;

		private var buttonType:int;
		private static var butonSize:int=10;

		private static var LU:int=1;
		private static var LM:int=2;
		private static var LD:int=3;
		private static var CU:int=4;
		private static var CD:int=5;
		private static var RU:int=6;
		private static var RM:int=8;
		private static var RD:int=9;
		private static var C:int=10;
		private var desktop:DrawDesktop;
		private var sourceSprite:Sprite;
		private var start_location:Point;
		private var start_height:int;
		private var start_width:int;
		private var component:UIComponent;
		private var _dComponent:DComponent;
		private var compToolTip:ComponentToolTip;

		private var topLeftPoint:Point=new Point();
		private var bottomRightPoint:Point=new Point();

		public function ComponentResizeContainer(component:DComponent) {
			super();
			desktop=Application.application.desktop;
			dComponent=component;
			this.component=component.getController();
			this.width=this.component.width;
			this.height=this.component.height;
			this.x=this.component.x;
			this.y=this.component.y;
			this.component.x=0;
			this.component.y=0;
			var p:Point=new Point();
			p.x=0;
			p.y=0;
			topLeftPoint=desktop.localToGlobal(p);
			bottomRightPoint.x=topLeftPoint.x + desktop.width;
			bottomRightPoint.y=topLeftPoint.y + desktop.height;
			initButtons();
			this.addEventListener(ResizeEvent.RESIZE, resize);
			this.addEventListener(MoveEvent.MOVE, moveC);
			
		}

		public function set dComponent(value:DComponent):void {
			_dComponent=value;
		}

		public function get dComponent():DComponent {
			return _dComponent;
		}

		public function setFocusC(comp:DComponent):void {
			dComponent=comp;
			this.component=comp.getController();
			this.width=this.component.width;
			this.height=this.component.height;
			this.x=this.component.x;
			this.y=this.component.y;
			setButtonsLocation();
			setButtonsVisibility(true);
		}


		public function initButtons():void {
			buttonLU=new Button();
			buttonLU.setStyle("cornerRadius", 0);
			buttonLU.width=buttonLU.height=butonSize;
			buttonLU.addEventListener(MouseEvent.MOUSE_DOWN, setSizeLU);
			buttonLU.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonLU);

			buttonLM=new Button();
			buttonLM.setStyle("cornerRadius", 0);
			buttonLM.width=buttonLM.height=butonSize;
			buttonLM.addEventListener(MouseEvent.MOUSE_DOWN, setSizeLM);
			buttonLM.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonLM);

			buttonLD=new Button();
			buttonLD.setStyle("cornerRadius", 0);
			buttonLD.width=buttonLD.height=butonSize;
			buttonLD.addEventListener(MouseEvent.MOUSE_DOWN, setSizeLD);
			buttonLD.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonLD);

			buttonCU=new Button();
			buttonCU.setStyle("cornerRadius", 0);
			buttonCU.width=buttonCU.height=butonSize;
			buttonCU.addEventListener(MouseEvent.MOUSE_DOWN, setSizeCU);
			buttonCU.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonCU);

			buttonC=new Button();
			buttonC.width=buttonC.height=butonSize;
			buttonC.addEventListener(MouseEvent.MOUSE_DOWN, setSizeC);
			buttonC.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonC);

			buttonCD=new Button();
			buttonCD.setStyle("cornerRadius", 0);
			buttonCD.width=buttonCD.height=butonSize;
			buttonCD.addEventListener(MouseEvent.MOUSE_DOWN, setSizeCD);
			buttonCD.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonCD);

			buttonRU=new Button();
			buttonRU.setStyle("cornerRadius", 0);
			buttonRU.width=buttonRU.height=butonSize;
			buttonRU.addEventListener(MouseEvent.MOUSE_DOWN, setSizeRU);
			buttonRU.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonRU);

			buttonRM=new Button();
			buttonRM.setStyle("cornerRadius", 0);
			buttonRM.width=buttonRM.height=butonSize;
			buttonRM.addEventListener(MouseEvent.MOUSE_DOWN, setSizeRM);
			buttonRM.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonRM);

			buttonRD=new Button();
			buttonRD.setStyle("cornerRadius", 0);
			buttonRD.width=buttonRD.height=butonSize;
			buttonRD.addEventListener(MouseEvent.MOUSE_DOWN, setSizeRD);
			buttonRD.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			addChild(buttonRD);

			createToolTip();

			setButtonsLocation();
			setButtonsVisibility(true);
		}

		public function setButtonsVisibility(state:Boolean):void {
			this.graphics.clear();
			this.buttonLU.visible=state;
			this.buttonLM.visible=state;
			this.buttonLD.visible=state;
			this.buttonCU.visible=state;
			this.buttonCD.visible=state;
			this.buttonRU.visible=state;
			this.buttonRM.visible=state;
			this.buttonRD.visible=state;
			this.buttonC.visible=state;
			compToolTip.visible=state;
			if (state) {
				this.graphics.lineStyle(1, 0x000000000, .2);
				this.graphics.drawRect(0 - butonSize / 2, 0 - butonSize / 2, this.width + butonSize, this.height + butonSize);
				this.graphics.endFill();
			}
		}

		public function createToolTip():void {
			compToolTip=new ComponentToolTip();
			compToolTip.sourceComponent=this;
			compToolTip.visible=false;
			compToolTip.height=24;
			compToolTip.width=260;
			addChild(compToolTip);
		}

		public function setButtonsLocation():void {
			buttonLU.x=0 - butonSize;
			buttonLU.y=0 - butonSize;
			buttonLM.x=0 - butonSize;
			buttonLM.y=0 + this.height / 2 - butonSize / 2;
			buttonLD.x=0 - butonSize;
			buttonLD.y=0 + this.height;

			buttonRU.x=0 + this.width;
			buttonRU.y=0 - butonSize;
			buttonRM.x=0 + this.width;
			buttonRM.y=0 + this.height / 2 - butonSize / 2;
			buttonRD.x=0 + this.width;
			buttonRD.y=0 + this.height;

			buttonCU.x=0 + this.width / 2 - butonSize / 2;
			buttonCU.y=0 - butonSize;
			buttonC.x=0 + this.width / 2 - butonSize / 2;
			buttonC.y=0 + this.height / 2 - butonSize / 2;
			buttonCD.x=0 + this.width / 2 - butonSize / 2;
			buttonCD.y=0 + this.height;

			if (this.y - (1.5 * butonSize + this.compToolTip.height) < 0) {
				if (this.y + this.height + compToolTip.height < desktop.getDrawable().height) {
					compToolTip.y=this.height + 1.5 * butonSize;
					if (this.x < 0) {
						compToolTip.x=-1 * this.x + 3;
					}
					else {
						if (compToolTip.width > this.desktop.getDrawable().width - this.x) {
							compToolTip.x=-(compToolTip.width - (desktop.getDrawable().width - this.x));
						}
						else {
							compToolTip.x=0 - butonSize;
						}
					}
				}
				else {
					compToolTip.y=0.5 * butonSize + 1;
					if (this.x < 0) {
						compToolTip.x=-1 * this.x + 3;
					}
					else {
						if (compToolTip.width > this.desktop.getDrawable().width - this.x) {
							compToolTip.x=-(compToolTip.width - (desktop.getDrawable().width - this.x));
						}
						else {
							compToolTip.x=0 - butonSize;
						}
					}
				}
			}
			else {
				compToolTip.y=0 - 1.5 * butonSize - compToolTip.height;
				if (this.x < 0) {
					compToolTip.x=-1 * this.x + 3;
				}
				else {
					if (compToolTip.width > this.desktop.getDrawable().width - this.x) {
						compToolTip.x=-(compToolTip.width - (desktop.getDrawable().width - this.x));
					}
					else {
						compToolTip.x=0 - butonSize;
					}
				}
			}
			this._dComponent.getController().dispatchEvent(new ComponentResizeEvent(ComponentResizeEvent.COMPONENT_RESIZE));
		}

		private function resize(evt:ResizeEvent):void {
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x000000000, 0.2, true);
			this.graphics.drawRect(0 - butonSize / 2, 0 - butonSize / 2, this.width + butonSize, this.height + butonSize);
			this.graphics.endFill();
			component.height=this.height;
			component.width=this.width;
			setButtonsLocation();
		}
		public function resizeFomDComponent():void {
			this.y -= (dComponent.getSource().height-this.height)/2;
			this.x -= (dComponent.getSource().width-this.width)/2;
			this.height=dComponent.getSource().height;
			this.width=dComponent.getSource().width;
			//dComponent.getController().x=(dComponent.getSource().height-this.height)/2;
			//dComponent.getController().y=(dComponent.getSource().width-this.width)/2;
			
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x000000000, 0.2, true);
			this.graphics.drawRect(0 - butonSize / 2, 0 - butonSize / 2, this.width + butonSize, this.height + butonSize);
			this.graphics.endFill();
			setButtonsLocation();
		}

		private function moveC(evt:MoveEvent):void {
			component.x=this.x;
			component.y=this.y;
			setButtonsLocation();
		}


		public function setSizeRU(event:MouseEvent):void {
			buttonType=RU;
			start_location=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY)
			start_height=this.height;
			start_width=this.width;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonRU);
		}

		public function dragButtonRU(event:MouseEvent):void {

			this.height=start_height + (start_location.y - desktop.getDrawable().mouseY);
			this.width=start_width + (desktop.getDrawable().mouseX - start_location.x);
			if (this.width <= butonSize * 3) {
				this.width=butonSize * 3;
			}

			if (this.height <= butonSize * 3) {
				this.height=butonSize * 3;
			}
			else {
				this.y=desktop.getDrawable().mouseY + butonSize / 2;
			}
		}

		public function setSizeRM(event:MouseEvent):void {
			buttonType=RM;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonRM);
		}

		public function dragButtonRM(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			if (location.x > this.x + 3 * butonSize) {
				this.width=location.x - this.x - butonSize / 2;
			}
		}

		public function setSizeRD(event:MouseEvent):void {
			buttonType=RD;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonRD);
		}

		public function dragButtonRD(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			if (location.y > this.y + 3 * butonSize) {
				this.height=location.y - this.y - butonSize / 2;
			}
			if (location.x > this.x + 3 * butonSize) {
				this.width=location.x - this.x - butonSize / 2;
			}
		}


		public function setSizeCU(event:MouseEvent):void {
			buttonType=CU;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonCU);
		}

		public function dragButtonCU(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			var nh:Number=this.y + getHeight() - location.y;
			if (location.y < this.y + getHeight() - 3 * butonSize) {
				this.y=location.y;
				this.height=nh;
			}

		}

		public function setSizeC(event:MouseEvent):void {
			buttonType=C;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonC);
		}

		public function dragButtonC(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			this.y=location.y - this.height / 2;
			this.x=location.x - this.width / 2;
			setButtonsLocation();
		}

		public function setSizeCD(event:MouseEvent):void {
			buttonType=CD;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonCD);
		}

		public function dragButtonCD(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			if (location.y > this.y + 3 * butonSize) {
				this.height=location.y - this.y - butonSize / 2;
			}
		}

		public function setSizeLU(event:MouseEvent):void {
			buttonType=LU;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonLU);
		}

		public function dragButtonLU(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			var nh:Number=this.y + getHeight() - location.y;
			var nw:Number=this.x + getWidth() - location.x;
			if (location.y < this.y + getHeight() - 3 * butonSize) {
				this.y=location.y;
				this.height=nh;
			}
			if (location.x < this.x + getWidth() - 3 * butonSize) {
				this.x=location.x;
				this.width=nw;
			}
		}

		public function setSizeLM(event:MouseEvent):void {
			buttonType=LM;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonLM);
		}

		public function dragButtonLM(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			var nw:Number=this.x + getWidth() - location.x;
			if (location.x < this.x + getWidth() - 3 * butonSize) {
				this.x=location.x;
				this.width=nw;
			}
		}

		public function setSizeLD(event:MouseEvent):void {
			buttonType=LD;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragButtonLD);
		}

		public function dragButtonLD(event:MouseEvent):void {
			var location:Point=new Point(desktop.getDrawable().mouseX, desktop.getDrawable().mouseY);
			var nw:Number=this.x + getWidth() - location.x;
			if (location.y > this.y + 3 * butonSize) {
				this.height=location.y - this.y - butonSize / 2;
			}
			if (location.x < this.x + getWidth() - 3 * butonSize) {
				this.x=location.x;
				this.width=nw;
			}
		}

		public function stopDragging(event:MouseEvent):void {
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonRU);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonRM);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonRD);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonCU);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonCD);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonLU);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonLM);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonLD);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonC);
			//}
/* 			switch (buttonType) {
				case RU:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonRU);
					break;
				case RM:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonRM);
					break;
				case RD:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonRD);
					break;
				case CU:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonCU);
					break;
				case CD:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonCD);
					break;
				case LU:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonLU);
					break;
				case LM:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonLM);
					break;
				case LD:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonLD);
					break;
				case C:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragButtonC);
					break;
				default:
					break;
			} */
		}

		public function getHeight():Number {
			return this.height;
		}

		public function getWidth():Number {
			return this.width;
		}
	}
}

