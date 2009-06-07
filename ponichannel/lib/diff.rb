=begin
Module AlgorithmDiff

/*
 * Copyright (c) 2001,2002 todo.org All rights reserved.
 *
 * Redistribution and use in source and not-encrypted and not-binary
 * forms, with or without modification, are permitted provided that
 * the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by ksr and its contributors.
 * 3. Neither the name of the author nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

Description:
	This module computes longest common subsequence and optimal path in
	edit graph.

Algorithm:
	The algorithm of this software is based on [1].

	http://www.cs.arizona.edu/people/gene
	[1] E.W.Myers, "An O(ND) difference algorithm and its variations", Algorithmixa, 1 (1986), pp.251-266 
	[2] S.W.maner, "G.Myers, W.Miller, An O(NP) Sequence Comparison Algorithm", August 1989 
		The [2] describes better solution as for space consumption.

Interface:
	The following callbacks are called from traverse in case of meeting the events:
		def when_A(i, j)  when finding A specific difference: i, j are index values
		def when_B(i, j)  when finding B specific difference: i, j are index values
		def when_match(i, j) when finding match line: i, j are index values
	User class inherits Diff class to override these methods to implement 
	user specific behavior.

Methods:      
	Diff.new(arrayA, arrayB):
		computes difference of arrayA, arrayB. The equality between elements
is computed with == method of each element.
	traverse:
		calls callbacks with traversing optimal path in edit graph.
	optimalpath: return array of int
		returns optimal path in edit graph as int array.
		int array keeps x, y pairs. Even index element keeps x, odd index
		element keeps y. This function becomes available after computing
		ond and solving. 

Usage:
	a = IO::readlines("a.c");
	b = IO::readlines("b.c");
	print ("fail in diff\n") if (!Diff.new(a,b).traverse);
=end

module AlgorithmDiff
	class Diff
		def initialize(a, b)
			@A = a; @B = b; @M = a.size; @N = b.size; @path = []; @delta = @M - @N;
			return if (ond < 0);
			@a = 0; @b = 0; @match = 0; 
			solve;
		end

		def ond()
			ofs = @ofs = max = @M + @N;
			@v = Array.new(max * 2 + 2, 0);
			@snake = Hash.new();
			@nn = Array.new(max+1);
			d = 0; nextbest = 0;
			while (d <= max)
				n = Array.new(@N+1);
				@nn[d] = n;
				k = -d;
				best = nextbest;
				while (k <= d) 
					if ((k + @delta).abs > max - best)
						k+=2; next; 
					end
					a = @v[k - 1 + ofs]; b = @v[k + 1 + ofs];
					y = ( (k == -d) || (k != d) && (a < b)) ? b : a + 1;
					x = y - k; count = 0;
					while( x < @M && y < @N && @A[x] == @B[y])
						x += 1; y += 1; count+= 1;
					end
					p = n[y]; p == nil ? n[y] = p = [x]: n[y] = (p << x);
					if (count > 0) then
						s = @snake[idx = x + y * @M]; s = 0 if s == nil;
					if (x >= 0 && s < count)
						@snake[idx] = count;
					end
				end
				@v[k + ofs] = y; 
				if( x == @M && y == @N ) then 
					@v = nil;
					return @d = d; 
				end
				k += 2;
				nextbest = ((pos = x+y) > nextbest) ? pos: nextbest;
			end
			d += 1;
		end
		@v = nil; @d = -1; 
	end
	def addl(x, y)
		@path << y << x;
	end
	def solve
		d = @d - 1; addl(x = @M, y = @N); mx = -1; my = -1; p = nil; s = nil;
		while (d >= 0) 
			p = @nn[d];
			s = @snake[x + y * @M]; s = 0 if s == nil;
			px = x - s; py = y - s; mx = -1; my = -1;
			if (((q = p[py-1]) != nil) && q.index(px) != nil) then
				mx = px; my = py - 1; addl(px, py);
			elsif (((q = p[py]) != nil) && q.index(px - 1) != nil) then
				mx = px - 1; my = py; addl(px, py);
			elsif (((q = p[py]) != nil) && q.index(px) != nil) then
				mx = px; my = py;
			end
			addl(mx, my); x = mx; y = my;
			break if (x == 0 && y == 0);
			d -= 1;
		end
		addl(0, 0); @path = @path.reverse;
		if (@path[2] == 0 && @path[3] == 0) then @path.shift; @path.shift; end
		@snake.clear(); @nn.clear(); @snake = nil; @nn = nil;
	end
	def optimalpath() @path end
	def traverse 
		return false if (@d < 0);
		l = @path; i = 0; size = l.size - 2;
		while (i < size) 
			x = l[i]; y = l[i+1]; j = i + 2; mx = l[j]; my = l[j+1];
			if (x == mx) then while (y < my) do when_B(mx,y); @b += 1; y += 1; end
			elsif (y == my) then while (x < mx) do when_A(x,my); @a += 1; x += 1; end
			else while (x < mx && y < my) do when_match(x, y); x += 1; y += 1; @match += 1; end
			end
			i = j;
		end
		return true;
	end
	def when_A(i, j)
#    print "#{i} #{j} > ", @A[i];
	end
	def when_B(i, j)
#    print "#{i} #{j} < ", @B[j];
	end
	def when_match(i, j)
#		print "#{i} #{j} = ", @B[j];
	end
	def diffs() end
	def statics()  [@a, @b, @match, @d, @M, @N]; end
end
end

#d = SDiff.new("aaaa\ncccc", "aaaa\nbbbb")
#p d
#p d.traverse
#p d.statics
#p d.diffs


#  def do_diff(name, p, q, msg);
#    if (!(d = SDiff.new(p, q)).traverse) then show_msg('TikiDiffError'); return; end 
#    c = []; 
#    c << sprintf("<b>%s</b>&nbsp;%s<br>", Page::dohtmlescape(name), Page::dohtmlescape(msg));
#    p = d.statics; c << sprintf('del %d:add %d:eq %d<br>', p[0], p[1], p[2]); 
#    return show_ropage(@name, (c << $hr << d.diffs));
#  end
#  def show_diff(name)
#    p = @sys.repository.getrecentbackupdataandmtime(name);
#    q = @sys.repository.load(name);
#    if (p == nil || q == nil) then show_msg('TikiBackupNotExistError'); return; end
#    do_diff(name, p[0], q, "diff recent(#{p[1]}) and #{name}");
#  end
