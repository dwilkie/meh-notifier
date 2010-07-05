# Represents the remote PaypalIpn resource
class RemotePaypalIpn < RemoteRequest
  def create(paypal_ipn)
    uri = URI.join(
      @remote_application_uri,
      "paypal_ipns"
    )
    params = paypal_ipn.params
    params = {"paypal_ipn" => params}.to_query
    AppEngine::URLFetch.fetch(
      uri.to_s,
      :payload => params,
      :method => 'POST',
      :follow_redirects => false,
      :headers => {"Content-Type" => "application/x-www-form-urlencoded"}
    ).code == "200" ? paypal_ipn.destroy : nil
  end
end

