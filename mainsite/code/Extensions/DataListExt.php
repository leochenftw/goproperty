<?php

class DataListExt extends Extension
{
    public function format($map = null)
    {
        $lst = $this->owner;
        $formated = array();
        foreach ($lst as $item) {
            $formated[] = $item->format($map);
        }
        return $formated;
    }

    public function SumFunction($function_name)
    {
        $lst = $this->owner;
        $n = 0;
        foreach ($lst as $item) {
            $n += $item->{$function_name}();
        }
        return $n;
    }

    public function call($function_name, $params = null)
    {
        $result = array();
        foreach ($lst as $item) {
            $sub_result = !empty($params) ? $item->call_user_func($function_name, $params) : $item->{$function_name}();
            if (!empty($sub_result)) {
                $result[] = $sub_result;
            }
        }

        return $result;
    }
}
