<?php

class Payment extends PaystationPayment
{
    /**
     * Database fields
     * @var array
     */
    protected static $db = array(
        'ValidUntil'    =>  'Date'
    );

    /**
     * Event handler called before writing to the database.
     */
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        if (empty($this->ValidUntil) && !empty($this->NextPayDate)) {
            $next_pay_date = date($this->NextPayDate);
            $this->ValidUntil = date('Y-m-d', strtotime($next_pay_date . ' + ' . ($this->PaymentFrequency - 1) . ' days'));
        }
    }

    public function PaidFor()
    {
        if ($this->OrderClass == 'Member') {
            return 'Tradesman account subscription <span class="period">(' . date('Y-m-d', strtotime($this->ProcessedAt)) . ' - ' . date('Y-m-d', strtotime($this->ProcessedAt. ' + ' . $this->PaymentFrequency . ' days')) . ')</span>';
        }

        if ($this->OrderClass == 'PropertyPage') {
            return 'Property list: ' . Versioned::get_by_stage('PropertyPage', 'Stage')->byID($this->OrderID)->Title;
        }
    }

    protected function create_next_payment($fp_token, $scheduled_payment = null)
    {
        $scheduled_payment = new Payment();
        parent::create_next_payment($fp_token, $scheduled_payment);
    }

    public function ExpireMembership()
    {

    }
}
