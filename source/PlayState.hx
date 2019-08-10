package;

import djFlixel.CTRL;
import djFlixel.FLS;
import djFlixel.fx.BoxFader;
import djFlixel.gui.Align;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.text.FlxTypeText;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Json;
import ink.FlxStory;
import ink.runtime.Choice;
import openfl.Assets;
using flixel.util.FlxStringUtil;
using StringTools;

class PlayState extends FlxState
{
	var P:Dynamic;
	private var autoText:TypeTextTwo;
	private var continueCursor:FlxSprite;
	private var inkStory:FlxStory;
	private var highLight:FlxSprite;
	private var curSelected:Int = 0;
	private var grpChoices:FlxTypedGroup<FlxText>;
	private var boxFade:BoxFader;
	private var WINDOWSIZE:FlxPoint = new FlxPoint(168, 112);
	private var prefix:String = "fulp";
	
	private var bg:FlxSprite;

	private var choicesOffsets:Float = 18;
	
	override public function create():Void
	{
		P = FLS.JSON.playstate;
		
		bg = new FlxSprite(-50, 39).makeGraphic(10, 10);
		bg.setGraphicSize(0, 112);
		bg.updateHitbox();
		add(bg);
		
		//var overlay:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.placeholderBG__png);
		//add(overlay);
		
		boxFade = new BoxFader(4, 39, WINDOWSIZE.x, WINDOWSIZE.y);
		boxFade.setColor(FlxColor.BLACK);
		//add(boxFade);
		
		inkStory = new FlxStory(AssetPaths.daStory__json);
		inkStory.Continue();
		trace(inkStory.canContinue);
		trace(inkStory.path.componentsString);
		trace(inkStory.currentText);
		
		autoText = new TypeTextTwo(10, 160, FlxG.width - 20, inkStory.currentText, 24);
		autoText.setTypingVariation(0.3);
		autoText.start(0.03, true, false);
		add(autoText);
		
		continueCursor = new FlxSprite(0, 0).makeGraphic(10, 10);
		Align.screen(continueCursor, "center", "bottom", 13);
		add(continueCursor);
		
		highLight = new FlxSprite(181);
		highLight.alpha = 0.5;
		highLight.makeGraphic(Std.int(66), Std.int(13), FlxColor.BLUE);
		add(highLight);
		
		FlxTween.tween(highLight, {alpha: 0.9}, 0.18, {type:FlxTweenType.PINGPONG, ease:FlxEase.quadInOut, loopDelay:0.05});
		
		grpChoices = new FlxTypedGroup<FlxText>();
		add(grpChoices);
		
		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.watch.addQuick("story can continue", inkStory.canContinue);
		FlxG.watch.addQuick("Text length: ", autoText.text.length);
		FlxG.watch.addQuick("Is Finished", autoText.isFinished);
		FlxG.watch.addQuick("Is Paused", autoText.paused);

		var justSelected:Bool = false;
		grpChoices.forEach(function(txt:FlxText){grpChoices.remove(txt, true); });
		
		
		if (inkStory.currentChoices.length > 0)
		{
			if (autoText.isFinished)
			{
				highLight.visible = true;
				
				for (i in 0...inkStory.currentChoices.length)
				{
					var choice:Choice = inkStory.currentChoices[i];
					
					var choiceTxt:FlxText = new FlxText(183, (choicesOffsets * i) + 28, 0, choice.text, Std.int(choicesOffsets - 2));
					grpChoices.add(choiceTxt);
					
					if (FlxG.onMobile)
					{
						for (touch in FlxG.touches.list)
						{
							if (touch.overlaps(choiceTxt) && touch.justPressed)
							{
								if (curSelected == i)
								{
									inkStory.ChooseChoiceIndex(curSelected);
									inkStory.Continue();
									autoText.resetText(inkStory.currentText);
									autoText.start(null, true);
									
									justSelected = true;
								}
								else
									curSelected = i;
							}
						}
						
						
					}
				}
				
				
				if (FlxG.keys.justPressed.SPACE)
				{
					trace('tried to choose option');
					inkStory.ChooseChoiceIndex(curSelected);
					inkStory.Continue();
					autoText.resetText(inkStory.currentText);
					autoText.start(null, true);
					
					justSelected = true;
				}	
			}
			else
				highLight.visible = false;
			
			if (CTRL.justPressed(CTRL.UP))
			{
				curSelected -= 1;
			}
			if (CTRL.justPressed(CTRL.DOWN))
			{
				curSelected += 1;
			}
			
			if (curSelected < 0)
				curSelected = inkStory.currentChoices.length - 1;
			if (curSelected >= inkStory.currentChoices.length)
				curSelected = 0;
			
			highLight.y = (choicesOffsets * curSelected) + 28;
			
			
		}
		else
			highLight.visible = false;
		
		if (inkStory.canContinue && autoText.isFinished)
		{
			FlxFlicker.flicker(continueCursor, 0, 0.27, false, false);
		}
		else
		{
			continueCursor.visible = false;
		}
		
		var tryAdvText:Bool = false;
		
		if (FlxG.keys.justPressed.SPACE)
			tryAdvText = true;
		
		if (FlxG.onMobile)
		{
			
			for (touch in FlxG.touches.list)
			{
				if (touch.justPressed && touch.y >= autoText.y)
				{
					tryAdvText = true;
				}
			}
		}
		
		if (tryAdvText && !justSelected)
		{
			
			advText();
		}
		
		#if debug
		//FLS.debug_keys();// F12 key reloads dynamic assets
		#end
	}
	
	private function advText():Void
	{
		trace('tried to advance text');

		if (!autoText.isFinished)
		{
			trace("tried to skip...");
			autoText.skip();
		}
		else
		{
			if (inkStory.canContinue)
			{
				trace("story can continue");
				inkStory.Continue();
				
				fulpCheck();
				
				if (!inkStory.currentText.toLowerCase().startsWith(prefix))
				{
					autoText.resetText(inkStory.currentText);
					autoText.start(null, true);
				}
				
			}
			else if (inkStory.currentChoices.length == 0)
			{
				autoText.resetText("TO BE CONTINUED LOL THE END");
				autoText.start(null, true);
			}
		}
	}
	
	private function fulpCheck():Void
	{
		trace("FULP COMMAND");
		var message:String = inkStory.currentText;
		
		if (message.toLowerCase().startsWith(prefix))
		{
			var args:Array<String> = message.substr(prefix.length).split(" ");
			var command = args.shift().toLowerCase().trim();
			FlxG.log.add(command);
			var tmr:Float = 0;
			
			switch (command) 
			{
				case "log":
					FlxG.log.add(args.slice(0).join(" ").trim());
				case "fadein":
					boxFade.setColor(FlxColor.BLACK);
					boxFade.fadeOff();
					FlxG.log.add("fading in");
				case "fadeout":
					boxFade.fadeColor(FlxColor.BLACK);
					tmr = 1;
					FlxG.log.add("Fading out");
				case "setbg":
					bg.loadGraphic("assets/images/bgs/" + args[0].trim() + ".png");
					bg.setGraphicSize(0, 112);
					bg.updateHitbox();
				default:
					FlxG.log.add("Busted command somewhere....");
					
			}
			
			// make this better lol
			new FlxTimer().start(tmr, function(tim:FlxTimer)
			{
				if (inkStory.canContinue)
				{
					trace("CONTINUED: " + command);
					inkStory.Continue();
					fulpCheck();
				}
			});
		}
	}
}
