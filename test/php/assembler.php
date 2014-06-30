<?php

interface TokenInterface {
	
}

abstract class AbstractToken {
	protected $token;

	public function __construct($token)
	{
		$this->token = $token;
	}

	public function __toString()
	{
		return (string)$this->token;
	}
}

class Operand extends AbstractToken implements TokenInterface {

}

class OperandCombination extends AbstractToken implements TokenInterface {
	public function __construct(Operand $operand1 = null, Operand $operand2 = null) {
		if(!isset($operand1) AND !isset($operand2)) {
			$this->token = "NO_OPERANDS";
		} elseif (isset($operand1) AND isset($operand2)) {
			$this->token = $operand1->__toString() . "," . $operand2->__toString();
		} elseif (isset($operand1)) {
			$this->token = $operand1->__toString();
		}
	}
}

class Instruction extends AbstractToken implements TokenInterface {

}

class Register extends AbstractToken implements TokenInterface {
	
}


class OpcodeMap {
	public $opcodeMap;

	public function __construct()
	{
		$this->opcodeMap = array();
	}

	public function Add(Instruction $instruction, $code, Operand $operand1 = null, Operand $operand2 = null)
	{
		if(!isset($this->opcodeMap[$instruction->__toString()])) {
			$this->opcodeMap[$instruction->__toString()] = array();
		}

		$operandCombination = new OperandCombination($operand1, $operand2);
$this->opcodeMap[$instruction->__toString()][$operandCombination->__toString()] = $code;
/*
		if($code) {
			if(!isset($this->opcodeMap[$instruction->__toString()][$code])) {
				$this->opcodeMap[$instruction->__toString()][$code] = null;
			}
		}
		if($operand1) {
			if(!isset($this->opcodeMap[$instruction->__toString()][$code])) {
				$this->opcodeMap[$instruction->__toString()][$code] = array();
			}
			$this->opcodeMap[$instruction->__toString()][$code]["operand1"] = $operand1->__toString();
			if($operand2) {
				$this->opcodeMap[$instruction->__toString()][$code]["operand2"] = $operand2->__toString();
			}
		}
*/
	}

	public function Load($filename)
	{
		$handle = @fopen($filename, "r");
		if ($handle) {
		    while (($buffer = fgets($handle, 4096)) !== false) {
		    	if((substr($buffer, 0, 1) != '#') AND ($buffer != "\n")) {
					$operand1 = null;
					$operand2 = null;

		    		if(substr($buffer, 0, 5) == "Table") {

		    		} elseif (substr($buffer, 0, 8) == "Referrer") {

		    		} elseif (substr($buffer, 0, 7) == "AVXcode") {

		    		} elseif (substr($buffer, 0, 8) == "EndTable") {
// Only read in the first table then exit
		    			return;
		    		} else {
		    			list($code, $rest) = explode(":", $buffer);
		    			$rest = substr($rest, 1, strlen($rest) - 1);
		    			$instruction = explode(" ", $rest);

		        		if(isset($instruction[0])) {
			        		$instruction[0] = trim($instruction[0]);
			        		if((substr($instruction[0],strlen($instruction[0]) - 4, 4) == "/D/Q") OR
			        		   (substr($instruction[0],strlen($instruction[0]) - 4, 4) == "/W/D") OR
			        		   (substr($instruction[0],strlen($instruction[0]) - 6, 6) == "/W/D/Q")
			        			) {
			        			$iarray = explode("/", $instruction[0]);
			        			$instructions = $iarray;
			        			$index = 0;
			        			foreach($iarray as $i) {
			        				if($index > 0) {
			        					$instructions[$index] = $instructions[0] . $instructions[$index];
			        				}
			        				$index++;
			        			}
			        			$instructions = array_reverse($instructions);
			        			$discard = array_pop($instructions);
			        		} elseif ((substr($instruction[0],strlen($instruction[0]) - 2, 2) == "/B")) {
			        			$iarray = explode("/", $instruction[0]);
			        			$instructions = array();
			        			$instructions[0] = $iarray[0] . $iarray[1];
			        		} else {
			        			$instructions = explode("/", $instruction[0]);
			        		}
			        		foreach($instructions as $i) {

			        			$instruction[0] = $i;

				        		if($instruction[0] != "") {
					        		if ((substr($instruction[0], 0, 3) != "Grp") AND
					        			($instruction[0] != "escape")
					        			) {
	//			        				echo $code . "\n";
	//				        			echo $instruction[0] . "\n";
						        		if(isset($instruction[1])) {
						        			$instruction[1] = trim($instruction[1]);
						        			if($instruction[1] != "") {
						        				if(($instruction[1] != "(Prefix)") AND 
						        				   ($instruction[1] != "(i64)") AND 
						        				   ($instruction[1] != "(d64)") AND 
						        				   ($instruction[1] != "(f64)"))
						        				{
	//					        					echo $instruction[1] . "\n";
						        					$operands = explode(",", $instruction[1]);
	//					        					print_r($operands);
						        					if(isset($operands[0])) {
						        						$operand1 = new Operand($operands[0]);
						        					}
						        					if(isset($operands[1])) {
						        						$operand2 = new Operand($operands[1]);
						        					}
												} else {

												}
											}
						        		}

						        		if(isset($instruction[0]) AND isset($code) AND isset($operand1) AND isset($operand2)) {
						        			$this->Add(new Instruction($instruction[0]), $code, $operand1, $operand2);
						        		} elseif (isset($instruction[0]) AND isset($code) AND isset($operand1)) {
						        			$this->Add(new Instruction($instruction[0]), $code, $operand1);
						        		} elseif (isset($instruction[0]) AND isset($code)) {
						        			$this->Add(new Instruction($instruction[0]), $code);
						        		}


					        		} else {

					        		}
				        		}
			        		}
		        		}
		    		}
		    	}
		    }
		    if (!feof($handle)) {
		        echo "Error: unexpected fgets() fail\n";
		    }
		    fclose($handle);
		}
	}
}

$opcodeMap = new OpcodeMap();
$opcodeMap->Load("intel.map");
/*
$instruction = new Instruction("ADD");
$opcodeMap->add($instruction, 0x00, new Operand("Eb"), new Operand("Gb"));
$instruction = new Instruction("ADD");
$opcodeMap->add($instruction, 0x01, new Operand("Ev"), new Operand("Gv"));
$instruction = new Instruction("NOP");
$opcodeMap->add($instruction, 0x90);
*/
print_r($opcodeMap);
