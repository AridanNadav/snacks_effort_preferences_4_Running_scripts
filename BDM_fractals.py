#!/usr/bin/env python

import pygame, sys,os, random
from pygame.locals import * 

def instructions():
    screen.fill((0, 0, 0))
    text1=font.render("As explained, please indicate how much do you like",1,white)
    text2=font.render("each of the following pictures by clicking on the bar below",1,white)
    text3=font.render("Please click to continue...",1,white)
    textpos1=text1.get_rect(centerx=width/2, centery=height/2-40)
    textpos2=text2.get_rect(centerx=width/2, centery=height/2)
    textpos3=text3.get_rect(centerx=width/2, centery=height/2+60)
    screen.blit(text1, textpos1)
    screen.blit(text2, textpos2)
    screen.blit(text3, textpos3)
    pygame.display.flip()
    while 1:
        event=pygame.event.poll()
        if event.type==MOUSEBUTTONDOWN:
            pygame.event.clear()
            break

def display_trial(fractals,pos):
    file = os.path.join("fractals",fractals)
    pic=pygame.image.load(file).convert()
    screen.fill((0, 0, 0))
    pygame.draw.rect(screen, white, rect)
    text=font.render("0    1     2     3     4     5     6     7     8     9    10",1,white)
    textpos=text.get_rect(centerx=width/2, centery=height-30)
    screen.blit(text, textpos)
    screen.blit(pic,pic.get_rect(centerx=width/2, centery=height/2))
    draw_marker(pos)
    pygame.display.flip()
    
def draw_marker(pos):
    marker = pygame.Rect(pos-2,(height-75),4,30)
    pygame.draw.rect(screen, blue, marker)
    pygame.display.flip()

def get_response():
    pygame.event.clear()
    while 1:
        event=pygame.event.poll()
        pos = pygame.mouse.get_pos()
        if pos[0] > width/2-225 and pos[0] < width/2+225 and pos[1]>height-70 and pos[1]<height-50:
            display_trial(stim,pos[0])
        
        
        if pygame.key.get_pressed()[K_LSHIFT] and pygame.key.get_pressed()[K_BACKQUOTE]:
            raise SystemExit
        if pygame.key.get_pressed()[K_LSHIFT] and pygame.key.get_pressed()[K_EQUALS]:
            save_image()
        if event.type==MOUSEBUTTONUP:
            pos = pygame.mouse.get_pos()
            if pos[0] > width/2-225 and pos[0] < width/2+225 and pos[1]>height-70 and pos[1]<height-50:
                bet=(pos[0]-(width/2-225))/45.0
                return bet
                break

def write_header():
    sd=("Trial"+'\t'+"StimName"+'\t'+"Liking"+'\t'+"RT"+'\n')
    sepname=subjid+"_fractals_BDM.txt"
    sep_path=os.path.join("Output",sepname)
    sepfile=open(sep_path, "a")
    sepfile.write(sd)
    sepfile.close()

def write_response(trial,bet,rt):
    sd=(str(trial)+'\t'+stim+'\t'+str(bet)+'\t'+str(rt)+'\n')
    sepname=subjid+"_fractals_BDM.txt"
    sep_path=os.path.join("Output",sepname)
    sepfile=open(sep_path, "a")
    sepfile.write(sd)
    sepfile.close()

def intertrial():
    screen.fill((0, 0, 0))
    text=font2.render("+",1,white)
    textpos=text.get_rect(centerx=width/2, centery=height/2)
    screen.blit(text, textpos)
    pygame.display.flip()
    pygame.time.wait(1000)

def end():
    screen.fill((0, 0, 0))
    text=font2.render("Thank you! Please get the experimenter.",1,yellow)
    textpos=text.get_rect(centerx=width/2, centery=height/2)
    screen.blit(text, textpos)
    pygame.display.flip()
    pygame.time.wait(5000)

subjid=sys.argv[1]
#subjid='TTT'
pygame.init()

# Set up variables
screen = pygame.display.set_mode((1920,1080), FULLSCREEN)
#screen = pygame.display.set_mode((1280,800), FULLSCREEN)
#screen = pygame.display.set_mode((1439,799))
white = (255, 255, 255)
yellow = (255, 255, 0)
blue=(0,0,255)
height=screen.get_height()
width=screen.get_width()
font = pygame.font.Font(None, 36)
font2 = pygame.font.Font(None, 72)
rect = pygame.Rect((width/2-225),(height-70),450,20)

#JR=["jollyrancherblue", "jollyranchergreen", "jollyrancherpurple", "jollyrancherred"]
#random.shuffle(JR)
#Pringles=[ "Pringles", "PringlesRed", "pringlescheezums"]
#random.shuffle(Pringles)
#keebler=["keeblerfudgestripes", "keeblerrainbow"]
#random.shuffle(keebler)

#stimulus list of 60 items
stimlist=["101.bmp", "102.bmp", "103.bmp", "104.bmp", "105.bmp", "106.bmp", "107.bmp", "108.bmp", "110.bmp", "111.bmp", "112.bmp", "113.bmp", "114.bmp", "115.bmp", "116.bmp", "117.bmp", "118.bmp", "119.bmp", "120.bmp", "121.bmp", "122.bmp", "123.bmp", "124.bmp", "125.bmp", "126.bmp", "127.bmp", "128.bmp", "129.bmp", "130.bmp", "131.bmp", "132.bmp", "133.bmp", "134.bmp", "135.bmp", "136.bmp", "137.bmp", "138.bmp", "139.bmp", "140.bmp", "141.bmp", "142.bmp", "143.bmp", "144.bmp", "145.bmp", "146.bmp", "147.bmp", "148.bmp", "149.bmp", "150.bmp", "151.bmp", "152.bmp", "153.bmp", "154.bmp", "155.bmp", "156.bmp", "157.bmp", "158.bmp", "159.bmp", "160.bmp"]

random.shuffle(stimlist)

trial=1

instructions()
write_header()
for stim in stimlist:

    pygame.mouse.set_pos(width/2,height/2)

    stimonset=pygame.time.get_ticks()
    display_trial(stim,(width/2))
  
    pygame.time.wait(500)
    
    bet=get_response()
    rt=pygame.time.get_ticks()-stimonset
    write_response(trial,bet,rt)
    
    intertrial()
    trial=trial+1
end()


