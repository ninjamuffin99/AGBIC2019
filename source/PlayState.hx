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
	private var grpChoiceBGs:FlxTypedGroup<FlxSprite>;
	private var grpActors:FlxTypedGroup<Actor>;
	private var boxFade:BoxFader;
	private var WINDOWSIZE:FlxPoint = new FlxPoint(1920, 1080);
	private var prefix:String = "fulp";
	
	private var bg:FlxSprite;

	private var choicesOffsets:Float = 36;
	private var choiceMultiplier:Float = 1.5;
	
	override public function create():Void
	{
		P = FLS.JSON.playstate;
		
		bg = new FlxSprite(0, 0).makeGraphic(1, 1, FlxColor.TRANSPARENT);
		add(bg);
		
		//var overlay:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.placeholderBG__png);
		//add(overlay);

		grpActors = new FlxTypedGroup<Actor>();
		add(grpActors);
		
		boxFade = new BoxFader(0, 0, WINDOWSIZE.x, WINDOWSIZE.y);
		boxFade.setColor(FlxColor.BLACK);
		add(boxFade);
		
		inkStory = new FlxStory(AssetPaths.daStory__json);
		inkStory.Continue();
		trace(inkStory.canContinue);
		trace(inkStory.path.componentsString);
		trace(inkStory.currentText);
		
		autoText = new TypeTextTwo(20, FlxG.height * 0.65, FlxG.width - 20, inkStory.currentText, 24);
		autoText.setTypingVariation(0.3);
		autoText.start(0.03, true, false);
		
		var blackBG:FlxSprite = new FlxSprite(autoText.x - 10, autoText.y - 10).makeGraphic(FlxG.width - 20, Std.int(FlxG.height * 0.32), FlxColor.BLACK);
		blackBG.alpha = 0.6;
		add(blackBG);

		add(autoText);
		
		continueCursor = new FlxSprite(0, 0).makeGraphic(10, 10);
		Align.screen(continueCursor, "center", "bottom", 13);
		add(continueCursor);
		
		highLight = new FlxSprite(181);
		highLight.alpha = 0.5;
		highLight.makeGraphic(Std.int(66), Std.int(13), FlxColor.BLUE);
		add(highLight);
		
		FlxTween.tween(highLight, {alpha: 0.9}, 0.18, {type:FlxTweenType.PINGPONG, ease:FlxEase.quadInOut, loopDelay:0.05});
		
		grpChoiceBGs = new FlxTypedGroup<FlxSprite>();
		add(grpChoiceBGs);

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
		grpChoiceBGs.forEach(function(bg:FlxSprite){grpChoiceBGs.remove(bg, true); });
		
		
		if (inkStory.currentChoices.length > 0)
		{
			if (autoText.isFinished)
			{
				highLight.visible = true;
				
				for (i in 0...inkStory.currentChoices.length)
				{
					var choice:Choice = inkStory.currentChoices[i];
					
					var choiceTxt:FlxText = new FlxText(183, (choicesOffsets * (i * choiceMultiplier)) + choicesOffsets, 0, choice.text, Std.int(choicesOffsets - 2));
					var choiceBG:FlxSprite = new FlxSprite(choiceTxt.x, choiceTxt.y - 2).makeGraphic(Std.int(choiceTxt.fieldWidth), choiceTxt.size + 4, FlxColor.BLACK);
					choiceBG.alpha = 0.6;
					choiceBG.screenCenter(X);
					grpChoiceBGs.add(choiceBG);
					
					grpChoices.add(choiceTxt);
					choiceTxt.screenCenter(X);
					
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
			
			highLight.y = (choicesOffsets * curSelected * choiceMultiplier) + choicesOffsets;
			
			
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

	private function actorCheck(ifTrue:Actor->Void, ifFalse:Void->Void):Void
	{
		var actorFound:Bool = false;
		grpActors.forEach(function(act:Actor)
		{
			if (curArg == act.name)
			{
				ifTrue(act);
				actorFound = true;
			}
		});

		if (!actorFound)
		{
			ifFalse();
		}

	}

	private var curArg:String = "";
	
	private function fulpCheck():Void
	{
		trace("FULP COMMAND");
		var message:String = inkStory.currentText;
		
		if (message.toLowerCase().startsWith(prefix))
		{
			var args:Array<String> = message.substr(prefix.length).split(" ");
			var command = args.shift().toLowerCase().trim();
			FlxG.log.add(command);
			trace(args);
			var tmr:Float = 0;

			if (args[0] != null)
				curArg = args[0].toLowerCase().trim();
			
			switch (command) 
			{
				case "log":
					FlxG.log.add(args.slice(0).join(" ").trim());
				case "fadein":
					boxFade.setColor(FlxColor.BLACK);
					boxFade.fadeOff(null, {steps: 6, time: 1});
					FlxG.log.add("fading in");
				case "fadeout":
					boxFade.fadeColor(FlxColor.BLACK);
					tmr = 1;
					FlxG.log.add("Fading out");
				case "setbg":
					bg.loadGraphic("assets/images/bgs/" + args[0].trim() + ".png");
					bg.setGraphicSize(0, FlxG.height);
					bg.updateHitbox();
				case "hide":
					actorCheck(function(act:Actor)
					{
						act.visible = false;
						trace("TRIED TO HIDE: " + act.name);
					}, function(){FlxG.log.warn("COULD NOT FIND ACTOR WITH NAME: " + curArg);});
				case "actor":
					actorCheck(function(act:Actor)
						{
							act.visible = true;
							if (args[1] != null)
								act.x = Std.parseFloat(args[1]);
							if (args[2] != null)
								act.y = Std.parseFloat(args[2]);
						},
						function()
						{
							var curX:Float = 0;
							var curY:Float = 0;

							if (args[1] != null)
								curX = Std.parseFloat(args[1]);
							if (args[2] != null)
								curY = Std.parseFloat(args[2]);

							var newActor:Actor = new Actor(curX, curY);
							newActor.loadGraphic("assets/images/actors/" + args[0].trim() + ".png");
							newActor.name = args[0].toLowerCase().trim();
							grpActors.add(newActor);
						});
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
