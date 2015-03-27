# coding: utf-8
require_relative "treeview/version.rb"

module TreeView
  HASH_CLASS = {}.class
  ARRAY_CLASS = [].class
  BRANCH_CLASS = [HASH_CLASS,ARRAY_CLASS]
  @@END_BRANCH = '\\__'
  @@BRANCH = '|__'
  @@SPACE = '   '

  def self.write_branch(pos,last,nest)
    @@SPACE * (nest - 1) + (pos != last ? @@BRANCH : @@END_BRANCH)
  end

  def self.valid(source)
    err = ->source{raise "invalid scheme:#{source}"}
    checks = []
    list = nil
    if BRANCH_CLASS.include?(source.class)
      list = source.values
      checks << ->e{valid(e) && e.class != source.class}
    else
      return true
    end
    
    list.each do |e|
      checks.each do |check|
        return false unless check.call(e)
      end
    end
    true
  end

  def self.finally(tree)
    tree = tree.split("\n").map!(&:chars)
    (0..(tree.length-1)).each do |y|
      next if y == tree.length
      tree[y].each.with_index do |ch,i|
        if ch == '|' && tree[y+1][i] == ' '
          tree[y+1][i] = '|'
        end
      end
    end
    tree.map!{|e|e.join('')}
    tree.join("\n")
  end
  
  def self.parse(source,nest = 0)
    str = ''

    if BRANCH_CLASS.include?(source.class)
      len = source.length
    end

    if source.class == HASH_CLASS
      source.each.with_index(1) do |(k,v) ,i|
        str << k.to_s + "\n"
        str << parse(v,nest)
      end
    elsif source.class == ARRAY_CLASS
      nest += 1
      source.each.with_index(1) do |v,i|
        str << write_branch(i,len,nest)
        str << parse(v, nest)
      end
    else
      str << source.to_s + "\n"
    end
    str
  end
  
  def self.tree(source)
    finally(parse(source))
  end

end
