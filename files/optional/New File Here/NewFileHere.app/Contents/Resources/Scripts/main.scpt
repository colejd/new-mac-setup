FasdUAS 1.101.10   ��   ��    k             l     ��  ��    1 + AppleScript to create a new file in Finder     � 	 	 V   A p p l e S c r i p t   t o   c r e a t e   a   n e w   f i l e   i n   F i n d e r   
  
 l     ��������  ��  ��        l     ��  ��    = 7 Use it in Automator, with the following configuration:     �   n   U s e   i t   i n   A u t o m a t o r ,   w i t h   t h e   f o l l o w i n g   c o n f i g u r a t i o n :      l     ��  ��    #  - Service receives: no input     �   :   -   S e r v i c e   r e c e i v e s :   n o   i n p u t      l     ��  ��      - In: Finder.app     �   "   -   I n :   F i n d e r . a p p      l     ��������  ��  ��        l     ��   ��      References:      � ! !    R e f e r e n c e s :   " # " l     �� $ %��   $ 1 +  - http://apple.stackexchange.com/a/129702    % � & & V     -   h t t p : / / a p p l e . s t a c k e x c h a n g e . c o m / a / 1 2 9 7 0 2 #  ' ( ' l     �� ) *��   ) 4 .  - http://stackoverflow.com/a/6125252/2530295    * � + + \     -   h t t p : / / s t a c k o v e r f l o w . c o m / a / 6 1 2 5 2 5 2 / 2 5 3 0 2 9 5 (  , - , l     �� . /��   . U O  - http://www.russellbeattie.com/blog/fun-with-the-os-x-finder-and-applescript    / � 0 0 �     -   h t t p : / / w w w . r u s s e l l b e a t t i e . c o m / b l o g / f u n - w i t h - t h e - o s - x - f i n d e r - a n d - a p p l e s c r i p t -  1 2 1 l     ��������  ��  ��   2  3 4 3 l     �� 5 6��   5  
 Know bugs    6 � 7 7    K n o w   b u g s 4  8 9 8 l     �� : ;��   : � z - When create/delete in desktop, after some time, the file is showed again and after deleted (it works, but it's strange)    ; � < < �   -   W h e n   c r e a t e / d e l e t e   i n   d e s k t o p ,   a f t e r   s o m e   t i m e ,   t h e   f i l e   i s   s h o w e d   a g a i n   a n d   a f t e r   d e l e t e d   ( i t   w o r k s ,   b u t   i t ' s   s t r a n g e ) 9  = > = l     ��������  ��  ��   >  ? @ ? l     A���� A r      B C B m      D D � E E  u n t i t l e d C o      ���� 0 	file_name  ��  ��   @  F G F l    H���� H r     I J I m     K K � L L  . t x t J o      ���� 0 file_ext  ��  ��   G  M N M l    O���� O r     P Q P m    	��
�� boovfals Q o      ���� 0 
is_desktop  ��  ��   N  R S R l     ��������  ��  ��   S  T U T l     �� V W��   V A ; get folder path and if we're in desktop (no folder opened)    W � X X v   g e t   f o l d e r   p a t h   a n d   i f   w e ' r e   i n   d e s k t o p   ( n o   f o l d e r   o p e n e d ) U  Y Z Y l   3 [���� [ Q    3 \ ] ^ \ O     _ ` _ r     a b a c     c d c l    e���� e n     f g f m    ��
�� 
cfol g l    h���� h 4   �� i
�� 
brow i m    ���� ��  ��  ��  ��   d m    ��
�� 
alis b o      ���� 0 this_folder   ` m     j j�                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   ] R      ������
�� .ascrerr ****      � ****��  ��   ^ k   & 3 k k  l m l l  & &�� n o��   n   no open folder windows    o � p p .   n o   o p e n   f o l d e r   w i n d o w s m  q r q r   & / s t s I  & -�� u v
�� .earsffdralis        afdr u m   & '��
�� afdmdesk v �� w��
�� 
rtyp w m   ( )��
�� 
alis��   t o      ���� 0 this_folder   r  x�� x r   0 3 y z y m   0 1��
�� boovtrue z o      ���� 0 
is_desktop  ��  ��  ��   Z  { | { l     ��������  ��  ��   |  } ~ } l     ��  ���    G A get the new file name (do not override an already existing file)    � � � � �   g e t   t h e   n e w   f i l e   n a m e   ( d o   n o t   o v e r r i d e   a n   a l r e a d y   e x i s t i n g   f i l e ) ~  � � � l  4 G ����� � O   4 G � � � r   8 F � � � e   8 B � � l  8 B ����� � n   8 B � � � 1   = A��
�� 
pnam � n   8 = � � � 2   9 =��
�� 
ditm � o   8 9���� 0 this_folder  ��  ��   � o      ���� 0 	file_list   � m   4 5 � ��                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��   �  � � � l  H O ����� � r   H O � � � b   H K � � � o   H I���� 0 	file_name   � o   I J���� 0 file_ext   � o      ���� 0 new_file  ��  ��   �  � � � l  P U ����� � r   P U � � � m   P Q����  � o      ���� 0 x  ��  ��   �  � � � l  V � ����� � T   V � � � Z   [ � � ��� � � E  [ b � � � o   [ ^���� 0 	file_list   � o   ^ a���� 0 new_file   � k   e ~ � �  � � � r   e t � � � b   e p � � � b   e n � � � b   e j � � � o   e f���� 0 	file_name   � m   f i � � � � �    � o   j m���� 0 x   � o   n o���� 0 file_ext   � o      ���� 0 new_file   �  ��� � r   u ~ � � � [   u z � � � o   u x���� 0 x   � m   x y����  � o      ���� 0 x  ��  ��   �  S   � ���  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � %  create and select the new file    � � � � >   c r e a t e   a n d   s e l e c t   t h e   n e w   f i l e �  � � � l  � � ����� � O   � � � � � k   � � � �  � � � l  � ���������  ��  ��   �  � � � I  � �������
�� .miscactvnull��� ��� obj ��  ��   �  � � � r   � � � � � I  � ����� �
�� .corecrel****      � null��   � �� � �
�� 
kocl � m   � ���
�� 
file � �� � �
�� 
insh � 4   � ��� �
�� 
cfol � o   � ����� 0 this_folder   � �� ���
�� 
prdt � K   � � � � �� ���
�� 
pnam � o   � ����� 0 new_file  ��  ��   � o      ���� 0 the_file   �  ��� � Z   � � � ��� � � =  � � � � � o   � ����� 0 
is_desktop   � m   � ���
�� boovfals � I  � ��� ���
�� .miscmvisnull���     obj  � o   � ����� 0 the_file  ��  ��   � k   � � � �  � � � I  � ��� ��
�� .miscslctnull���     obj  � n   � � � � � m   � ��~
�~ 
cwin � 1   � ��}
�} 
desk�   �  � � � r   � � � � � o   � ��|�| 0 the_file   � 1   � ��{
�{ 
sele �  ��z � I  � ��y ��x
�y .sysodelanull��� ��� nmbr � m   � � � � ?��������x  �z  ��   � m   � � � ��                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��   �  � � � l     �w�v�u�w  �v  �u   �  � � � l     �t � ��t   �   press enter (rename)    � � � � *   p r e s s   e n t e r   ( r e n a m e ) �  � � � l  � � ��s�r � O   � � � � � O   � � � � � I  � ��q ��p
�q .prcskprsnull���     ctxt � o   � ��o
�o 
ret �p   � 4   � ��n �
�n 
prcs � m   � � � � � � �  F i n d e r � m   � � � ��                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �s  �r   �  ��m � l     �l�k�j�l  �k  �j  �m       �i � ��i   � �h
�h .aevtoappnull  �   � **** � �g �f�e�d
�g .aevtoappnull  �   � ****  k     �  ?  F  M  Y  �  �		  �

  �  �  ��c�c  �f  �e     ) D�b K�a�` j�_�^�]�\�[�Z�Y�X�W ��V�U�T�S�R ��Q�P�O�N�M�L�K�J�I�H�G�F�E ��D�C ��B�A�b 0 	file_name  �a 0 file_ext  �` 0 
is_desktop  
�_ 
brow
�^ 
cfol
�] 
alis�\ 0 this_folder  �[  �Z  
�Y afdmdesk
�X 
rtyp
�W .earsffdralis        afdr
�V 
ditm
�U 
pnam�T 0 	file_list  �S 0 new_file  �R 0 x  
�Q .miscactvnull��� ��� obj 
�P 
kocl
�O 
file
�N 
insh
�M 
prdt�L 
�K .corecrel****      � null�J 0 the_file  
�I .miscmvisnull���     obj 
�H 
desk
�G 
cwin
�F .miscslctnull���     obj 
�E 
sele
�D .sysodelanull��� ��� nmbr
�C 
prcs
�B 
ret 
�A .prcskprsnull���     ctxt�d �E�O�E�OfE�O � *�k/�,�&E�UW X 
 ���l E�OeE�O� �a -a ,EE` UO��%E` OkE` O 0hZ_ _  �a %_ %�%E` O_ kE` Y [OY��O� [*j O*a a a *��/a a _ la  E` O�f  _ j Y !*a ,a  ,j !O_ *a ",FOa #j $UO� *a %a &/ 	_ 'j (UU ascr  ��ޭ