class OrdersController < ApplicationController
    require 'paypal-checkout-sdk'
    skip_before_action :verify_authenticity_token
    before_action :paypal_init, :except => [:index]
    def index; end
    def create_order
        price = session[:total]
        request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
        request.request_body({
          :intent => 'CAPTURE',
          :purchase_units => [
            {
              :amount => {
                :currency_code => 'USD',
                :value => price
              }
            }
          ]
        })
        begin
          response = @client.execute request
          order = Order.new
          order.price = price.to_i
          order.token = response.result.id
          if order.save
            return render :json => {:token => response.result.id}, :status => :ok
          end
        rescue PayPalHttp::HttpError => ioe
            puts ioe.status_code
            puts ioe.headers["debug_id"]
        end
      end
      def capture_order
        request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]
        begin
          response = @client.execute request
          order = Order.find_by :token => params[:order_id]
          order.paid = response.result.status == 'COMPLETED'
          if order.save
            return render :json => {:status => response.result.status}, :status => :ok
          end
        rescue PayPalHttp::HttpError => ioe
            puts ioe.status_code
            puts ioe.headers["paypal-debug-id"]
        end
      end
    private
    def paypal_init
      require 'paypal-checkout-sdk'
      client_id = 'AXuV_3pV6aDDNOmbpjRwDTEuVhhMSd65UWt-WyQdj0jQE68X4E7ZLJu4X0HKdu02JYIh7TMMb_ok9Gy-'
      client_secret = 'ECjwG3mr7cMRzMGv_niH2TO2w8mW1JOaLjebBiOsrvMM0LWbrDPin0_sf2Bdlr_ASf5-Q7MmOindZ8gh'
      environment = PayPal::SandboxEnvironment.new client_id, client_secret
      @client = PayPal::PayPalHttpClient.new environment
    end
  end